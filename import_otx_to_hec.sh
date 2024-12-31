#!/bin/bash

# Configuration
OTX_API_KEY="your_alienvault_api_key"
OTX_URL="https://otx.alienvault.com/api/v1/indicators/export"
HEC_ENDPOINT="https://<HEC-server>/services/collector"
HEC_TOKEN="your_hec_token"
CURL_OPTS="-s"  # Silent mode for curl

# Fetch AlienVault OTX IoC data
echo "Fetching IoC data from AlienVault OTX..."
response=$(curl $CURL_OPTS -H "X-OTX-API-KEY: $OTX_API_KEY" "$OTX_URL")

# Debug: Print the API response
echo "API Response: $response"

# Check if the API call was successful
if [[ $? -ne 0 ]]; then
    echo "Failed to fetch data from AlienVault OTX."
    exit 1
fi

# Check if the response is valid JSON and contains results
if ! echo "$response" | jq empty; then
    echo "Invalid JSON response from AlienVault OTX."
    exit 1
fi

if ! echo "$response" | jq -e '.results' > /dev/null; then
    echo "No results found in the response."
    exit 1
fi

# Transform data into Splunk HEC format
echo "Transforming data into Splunk HEC format..."
hec_data=$(echo "$response" | jq -c '.results[] | {time: (now | floor), event: .}')

# Check if the transformation was successful
if [[ $? -ne 0 ]]; then
    echo "Failed to transform data."
    exit 1
fi

# Send data to Splunk HEC
echo "Sending data to Splunk HEC..."
echo "$hec_data" | while read -r line; do
    curl $CURL_OPTS -X POST "$HEC_ENDPOINT" \
        -H "Authorization: Splunk $HEC_TOKEN" \
        -H "Content-Type: application/json" \
        --data "$line"
done

# Check if the data was sent successfully
if [[ $? -ne 0 ]]; then
    echo "Failed to send data to Splunk HEC."
    exit 1
fi

echo "Data successfully imported into Splunk HEC."
