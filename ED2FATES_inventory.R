rm(list = ls())

#This script requires two files 
#(1) ED2 structured .pss and .css files and 
#(2) a dummy file within the structure of FATES .css and .pss files


dir<- 'C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/'
# Step 1: Read the files (assuming CSV-like format for .css files)
# Use FATES structured BCI file as dummy
bci_file <- read.csv('C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/BCI_2015.css', header = TRUE,sep = "", stringsAsFactors = FALSE)

#this file is your own inventory file in ED2 format
yangambi_file <- read.csv('C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/yangambi_ED.css', header = TRUE,sep = "", stringsAsFactors = FALSE)


# Step 2: Check for row length differences
bci_rows <- nrow(bci_file)
yangambi_rows <- nrow(yangambi_file)

# If BCI has more rows than yangambi, truncate BCI
if (bci_rows > yangambi_rows) {
  bci_file <- bci_file[1:yangambi_rows, ]
} 

# If yangambi has more rows than BCI, pad BCI with NA rows
# Make sure bci_file and yangambi_file have matching number of rows
if (nrow(bci_file) < nrow(yangambi_file)) {
  rows_to_add <- nrow(yangambi_file) - nrow(bci_file)
  
  # Ensure new rows are added with matching column names
  new_rows <- data.frame(matrix(NA, nrow = rows_to_add, ncol = ncol(bci_file)))
  colnames(new_rows) <- colnames(bci_file)  # Ensure the column names match
  
  # Append new rows to bci_file
  bci_file <- rbind(bci_file, new_rows)
}

# Step 3: Choose which columns to overwrite in the BCI copy
# Example: If you want to overwrite "colA" in BCI with "col1" in yangambi
# Modify these column names as per your files
bci_file$time <- yangambi_file$time
bci_file$patch <- yangambi_file$patch  
bci_file$dbh <- yangambi_file$dbh  
bci_file$height <- yangambi_file$hite -1  
bci_file$pft <- yangambi_file$pft  
bci_file$nplant <- yangambi_file$n  

bci_file$pft <- 0

# Step 4: Save the new modified BCI file
#write.csv(bci_file, 'C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/Yangambi_copy.css', row.names = FALSE,sep = " ")
write.table(bci_file, 
            file = 'C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/yangambi.css', 
            row.names = FALSE, 
            col.names = TRUE, 
            sep = " ",     # Use space as the separator
            quote = FALSE) # Prevent quotation marks around values

dir<- 'C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/'

#Repeat process for .pss file
# Step 1: Read the files (assuming CSV-like format for .pss files)
bci_file <- read.csv('C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/BCI_2015.pss', header = TRUE,sep = "", stringsAsFactors = FALSE)

yangambi_file <- read.csv('C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/yangambi_ED.pss', header = TRUE,sep = "", stringsAsFactors = FALSE)


# Step 2: Check for row length differences
bci_rows <- nrow(bci_file)
yangambi_rows <- nrow(yangambi_file)

# If BCI has more rows than yangambi, truncate BCI
if (bci_rows > yangambi_rows) {
  bci_file <- bci_file[1:yangambi_rows, ]
} 

# If yangambi has more rows than BCI, pad BCI with NA rows
# Make sure bci_file and yangambi_file have matching number of rows
if (nrow(bci_file) < nrow(yangambi_file)) {
  rows_to_add <- nrow(yangambi_file) - nrow(bci_file)
  
  # Ensure new rows are added with matching column names
  new_rows <- data.frame(matrix(0, nrow = rows_to_add, ncol = ncol(bci_file)))
  colnames(new_rows) <- colnames(bci_file)  # Ensure the column names match
  
  # Append new rows to bci_file
  bci_file <- rbind(bci_file, new_rows)
}

# Step 3: Choose which columns to overwrite in the BCI copy
# Example: If you want to overwrite "colA" in BCI with "col1" in yangambi
# Modify these column names as per your files
bci_file$time <- yangambi_file$time
bci_file$patch <- yangambi_file$patch  # Overwrite more columns if needed
bci_file$trunk <- yangambi_file$trunk  # Overwrite more columns if needed
bci_file$age <- yangambi_file$age  # Overwrite more columns if needed
bci_file$area <- yangambi_file$area  # Overwrite more columns if needed

# Step 4: Save the new modified BCI file
#write.csv(bci_file, 'C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/Yangambi_copy.pss', row.names = FALSE,sep = " ")
write.table(bci_file, 
            file = 'C:/Users/stevdher/OneDrive - UGent/Documenten/postdoc/fates-tutorial-main/fates-tutorial-main/inventory_data/yangambi.pss', 
            row.names = FALSE, 
            col.names = TRUE, 
            sep = " ",     # Use space as the separator
            quote = FALSE) # Prevent quotation marks around values
