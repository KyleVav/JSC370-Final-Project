library(ipumsr)

ddi <- read_ipums_ddi("./data/xml_file.xml")
data <- read_ipums_micro(ddi, data_file="./data/data_file.dat.gz")