# Load necessary library
library(dplyr)

# Read the raw data
raw_data <- read.csv('./raw_data/raw_data.csv')

# Clean the data
cleaned_data <- raw_data %>%
  # Standardizing Gender values
  mutate(Gender = case_when(
    Gender %in% c("M", "male") ~ "Male",
    Gender %in% c("F", "female") ~ "Female",
    TRUE ~ Gender
  )) %>%
  # Sequenced should be 'Yes' only if rabies_status is 'Pos'
  mutate(sequenced = ifelse(rabies_status != "Pos", "No", sequenced)) %>%
  # Rabies lineage should be assigned only if rabies_status is 'Pos' and sequenced is 'Yes'
  mutate(rabies_lineage = ifelse(rabies_status == "Pos" & sequenced == "Yes", toupper(substr(rabies_lineage, 1, 1)), NA)) %>%
  # Drop NA values
  drop_na()

# Write the cleaned data to a new CSV file
write.csv(cleaned_data, './processed_data/cleaned_data.csv', row.names = FALSE)
