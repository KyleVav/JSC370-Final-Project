# Data

The data for inflation conversion, historic median home price, and historic 30-year fixed mortgage rates is contained in this folder as .csv files. IPUMS CPS does not allow
users to share the data so the files were not provided here, instead an R script that generates the API call used to aqquire the data is provided. To obtain the IPUMS CPS
data follow these steps:

1) First create an IPUMS account, this can be done on their website [here](https://account.ipums.org/user/new)

2) Generate an API key using your IPUMS account, this can be done through their developer portal, an IPUMS tutorial is provided [here](https://developer.ipums.org/docs/v2/get-started/#:~:text=IPUMS%20users%20can%20obtain%20an,that%20govern%20IPUMS%20website%20usage.)

3) Run the R script contained in this folder, you will need to replace the IPUMS_API_KEY variable with the key that you generated, once the script is run there should be two
files, one .dat file and one .xml file; these are the data files.

4) To load the data into R, use the second script in this folder that uses the ipumsr package to load the data into an R dataframe