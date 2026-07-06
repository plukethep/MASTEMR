
library(glue)
library(tidyverse)
library(here)
#source(here("MASTEMR_functions.R"))

# On Richard's machine
# source("/Users/k1765032/Library/CloudStorage/OneDrive-King'sCollegeLondon/Peter Kemp's files - MASTEMR/MASTEMR_functions.R")
source("/Users/k1765032/Library/CloudStorage/OneDrive-King\'sCollegeLondon/Peter\ Kemp\'s\ files\ -\ MASTEMR/MASTEMR_functions.R")

src <- "/Users/k1765032/Library/CloudStorage/OneDrive-King'sCollegeLondon/Peter Kemp's files - MASTEMR/"
dest <- "/Users/k1765032/Documents/Teaching/STEM MA/Quantitative module/R/Temp/MASTEMR/"
MASTEMR_cache <- "/Users/k1765032/Documents/Teaching/STEM MA/Quantitative module/R/Temp/MASTEMR/Cache/"


library(tictoc)

# renders to avoid the google drive locking bug
# render time = 5 mmins approx
tic()
copy_run(type = "booklet", dest= dest, src=src, proj_name = "MASTEMR")
toc()

xchapter_links() 
# Run to here

# xchapter_links(src="C:\\temp\\MASTEMR\\_site", 
#                dest="C:\\temp\\website") # dest <> src

# then run these commands
system('xcopy "C:\\tmp\\MASTEMR\\images\\" "C:\\tmp\\MASTEMR\\_site\\chapters\\images\\" /y /E /H /C /I')
system('xcopy "C:\\tmp\\MASTEMR\\images\\" "C:\\tmp\\MASTEMR\\_site\\images\\" /y /E /H /C /I')
system('xcopy "C:\\tmp\\MASTEMR\\_site\\" "C:\\github\\peterejkemp.github.io\\v3\\" /y /E /H /C /I')

###################### Richard to run to render
dest <- r'[/Users/k1765032/Library/CloudStorage/OneDrive-King\'sCollegeLondon/MASTEMR]'
setwd(dest)
system('quarto render')

source("MASTEMR_setup.R") # refresh all the datasets

# or load from cached dataset
MASTEMR_cache <- r"[D:/MASTEMR/cache/]" # Petes_PC
MASTEMR_cache <- r"[C:/temp/cache/MASTEMR/]"

proj_folder <- r"(G:\My Drive\Kings\Code\MASTEMR\)"
proj_folder <- r"(C:/Users/Peter/Google Drive/Kings/Code/MASTEMR/)"

OpenAnalysis_load_ALL(use_cache = FALSE, # set to TRUE to reload dataset and store as feather
                      report_cache_folder=MASTEMR_cache,
                      over_write=FALSE)

dest <- r'[C:\temp\MASTEMR]'
setwd(dest)

system(paste0('quarto.cmd render "/chapters/02-4-Intro_to_graphs.qmd"'))

## this renders the whole thing
## copies the files to a non-google drive and renders from there
copy_run(type = "booklet", 
         dest=r'[C:\temp\MASTEMR]', 
         src=r'[G:\My Drive\Kings\Code\MASTEMR]', 
         proj_name = "TRACER")

# ERROR: Include directive failed.
# in file C:\temp\MASTEMR\index.qmd, 
# could not find file C:\temp\MASTEMR\chapters\_01-Intro_to_quant_methods.qmd.