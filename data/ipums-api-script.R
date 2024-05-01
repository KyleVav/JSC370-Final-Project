library(httr)

IPUMS_API_KEY = "[API KEY]"

body <- '{
    "description": "API Extract",
    "data_structure": { 
        "rectangular": {
            "on": "P"
        }
    },
    "data_format": "fixed_width",
    "variables": {
      "YEAR":{},
      "AGE":{},
      "ASECWTH":{},
      "RELATE":{},
      "OWNERSHP":{},
      "STATEFIP": {},
      "COUNTY": {},
      "HHINCOME": {},
      "INCRETIR": {}
    },
    "samples": {'
# loop over years to add them all to "samples" part of body
for (year in 1976:2022) body <- paste0(body, "\"cps", year, "_03s\"", ":{},")
body <- paste0(body, "\"cps2023_03s\"", ":{}}}")

# post request with body
post_request <- POST(
  url = "https://api.ipums.org/",
  path = "extracts",
  query = list(
    "collection" = "cps",
    "version" = "beta"
  ),
  config = add_headers(
    "Authorization" = IPUMS_API_KEY,
    "Content-Type" = "application/json"
  ),
  body = body
)

get_content <- NULL
time_between_check <- 60
repeat{
  # get request
  get_request <- GET(
    url = "https://api.ipums.org/",
    path = "extracts",
    config = add_headers(
      "Authorization" = IPUMS_API_KEY,
      "Content-Type" = "application/json"
    ),
    query = list(
      "collection" = "cps",
      "version" = "beta"
    )
  )
  
  # check if request is completed
  get_content <- content(get_request)[[1]] #get the most recent request content
  if (get_content$status == "completed") break
  # if not wait 30s and then try again
  Sys.sleep(time_between_check)
}

# get urls of xml and data
data_link <- get_content$download_links$data$url
xml_link <- get_content$download_links$ddi_codebook$url

# write .dat to directory
data_get <- GET(
  url = data_link,
  config = add_headers(Authorization=IPUMS_API_KEY),
  write_disk("data_file.dat.gz", overwrite=TRUE)
)

# write .xml to directory
xml_get <- GET(
  url = xml_link,
  config = add_headers(Authorization=IPUMS_API_KEY),
  write_disk("xml_file.xml", overwrite=TRUE)
)