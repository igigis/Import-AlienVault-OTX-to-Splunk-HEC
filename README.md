# Bash Script for Importing AlienVault OTX to Splunk HEC Integration

## Description
This script enables seamless integration of Indicator of Compromise (IoC) data from AlienVault's OTX API into Splunk's HTTP Event Collector (HEC). The script fetches IoCs, validates the data, transforms it into Splunk-compatible JSON format, and imports it into your HEC instance.

### Key Features
- Fetches IoC data from AlienVault OTX.
- Transforms data into Splunk HEC format using `jq`.
- Imports data into HEC.
- Includes robust error handling and debugging output.

## Prerequisites
- **Install jq:** The script uses `jq` to parse and transform JSON data. Install it using your package manager:
  - On Ubuntu/Debian:
    ```bash
    sudo apt-get install jq
    ```
  - On CentOS/RHEL:
    ```bash
    sudo yum install jq
    ```
  - On macOS:
    ```bash
    brew install jq
    ```
- **AlienVault OTX API Key:** Replace `your_alienvault_api_key` with your actual AlienVault OTX API key.
- **Splunk HEC Endpoint and Token:** Replace `<hec-server>` and `your_hec_token` with your Splunk HEC endpoint and token.

## Setup Instructions

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/igigis/Import-AlienVault-OTX-to-Splunk-HEC
   cd Import-AlienVault-OTX-to-Splunk-HEC
   ```

2. **Edit Configuration:**
   Update the following variables in the script with your own credentials:
   - `OTX_API_KEY`: Your AlienVault API key.
   - `HEC_ENDPOINT`: Your Splunk HEC endpoint (e.g., `https://<hec-server>/services/collector`).
   - `HEC_TOKEN`: Your Splunk HEC token.

3. **Make the Script Executable:**
   ```bash
   sudo chmod +x import_otx_to_hec.sh
   ```

4. **Run the Script:**
   ```bash
   ./import_otx_to_hec.sh
   ```

5. **Set Up a Cron Job:**
   To run the script every 12 hours, add the following entry to your crontab:
   ```bash
   0 */12 * * * /path/to/import_otx_to_hec.sh >> /path/to/logfile.log 2>&1
   ```
   - Replace `/path/to/import_otx_to_hec.sh` with the full path to the script.
   - Replace `/path/to/logfile.log` with the desired path for storing logs.

## Example Output
For a sample JSON response, the transformed Splunk HEC data will look like this:
```json
{"time": 1698765432, "event": {"id": 3012, "indicator": "cyberwise.biz", "type": "domain", "title": null, "description": null, "content": ""}}
{"time": 1698765432, "event": {"id": 3013, "indicator": "biketools.ru", "type": "domain", "title": null, "description": null, "content": ""}}
{"time": 1698765432, "event": {"id": 3014, "indicator": "verified-deal.com", "type": "domain", "title": null, "description": null, "content": ""}}
```

## Troubleshooting

1. **Invalid JSON Response:**
   - Error: `Invalid JSON response from AlienVault OTX.`
   - Solution: Check if your API key is valid and the OTX API is accessible.

2. **No Results Found:**
   - Error: `No results found in the response.`
   - Solution: Verify if there are any IoCs available in your OTX feed.

3. **Data Transformation Issues:**
   - Error: `Failed to transform data.`
   - Solution: Ensure `jq` is installed and the response JSON structure matches the expected format.

4. **Failed to Send Data to Splunk:**
   - Error: `Failed to send data to Splunk HEC.`
   - Solution: Verify the HEC endpoint, token, and Splunk HEC server availability.


## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

## Conclusion
This script simplifies the process of importing IoC data from AlienVault OTX into Splunk HEC, enabling quick and efficient threat intelligence integration. For any questions or contributions, feel free to raise an issue or submit a pull request in the repository.

