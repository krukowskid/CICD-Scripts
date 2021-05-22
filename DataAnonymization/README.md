# Data Anonymization
Masking or data anonymization could be tricky. Sometimes you need to copy production data to Dev/Test environments, but it can't be done with real users data.

## CosmosDB (or any json) anonymization
There is no "one size fits all" solution, but this simple python script will give you an insight how it can be done. 
I chose Python instead of PowerShell because of processing time. 

### How it works? 
This script is getting random users from cool random user API (randomuser.me), and replaces personal information in json with downloaded data.
