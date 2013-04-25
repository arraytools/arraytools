# Loading required libraries
library("annotate")
library("hgu133plus2.db")
probe <- names(as.list(hgu133plus2SYMBOL))
symbol <- as.character(as.list(hgu133plus2SYMBOL))

# Define number of desired genes, arrays and output file name
ngene <- 20
narray <- 10
filename <- "E:/testdata/test/testdata.txt"

# Create the data
ngene <- min(length(probe), ngene)
set.seed(1234)
x <- matrix(rnorm(ngene*narray), nr=ngene)
x <- data.frame(probe=probe[1:ngene],
                symbol=symbol[1:ngene], round(x, 5))
colnames(x)[3:ncol(x)] <- paste("Array", 1:narray, sep="")
write.table(x, col.names=T, row.names=F, sep="\t", quote=F, file=filename)

##############################################################################################
# Procedure of importing the data in BRB-ArrayTools
#
# Open Excel -> Add-Ins -> ArrayTools -> Import data -> General Format Importer.
# File type: Arrays are saved in a horizontally aligned file. [Next]
# Click 'Browse' button to select the file <testdata.txt> [Next]
# Platforrm: Single-channel data. [Next]
# Single-channel data: Affymetrix probeset-summary data
#                      Chip Type: HG-U133 Plus 2.0 Array (hgu133plus2)
#                      check the option 'The data are already log2 transformed'
#                      [Next]
# General Format Importer:
#                Please select the header line that identifies the columns: probe symbol Array1 Array2 ...
#                First data line: 1007_s_at DDR1 -1.20707 ....
#                Probe Set ID: Col 1: probe
#                Data for first array begins in column: Col 3: Array 1
#                Data for second array begins in column: Col 4: Array 2
#                Logged Signal: Col 3: Array 1
#                [Next]
# Check the option 'I do not have an experiment descriptor file. Please create a template with just array ids.'
#                [Next]
# Data Import Wizard: Project location
#                     Project folder: 
#                     Project name:
#                     [Next]
# Refilter, normalize and subset the data: Uncheck all options under 'Spot filters', 'Normalization' and 'Gene filters' tabs.
#                     [OK]
# Proceed to Annotation?
#         Accept the default option of annotate affymetrix data with Bioconductor packages
#         [OK}
# Wait a couple of minutes for the program to generate annotation information for the data
# 
# Ready for downstream analyses!

