
## tools:

get_setup_code <- function(){
  
  setup_code <- '```{r}
    #| eval: true
    #| warning: false
    #| echo: false

    # options(max.print=10000)
    options(max.print=15)
    
  # only load this code if testing this file independently of overall project
  if(!exists("test")){
    warning("RUNNING LOCAL FILE LOAD")

    library(glue)
    node <- Sys.info()
	if(node["nodename"] == "KCLMLVXD9XH6P"){ # pete MAC
	  pisa_data <- "/Users/k1926273/Library/CloudStorage/OneDrive-King\'sCollegeLondon/Code/QERKCL_PISA/data/pisa/"
      base_location <- "/Users/k1926273/Library/CloudStorage/OneDrive-King\'sCollegeLondon/Code/MASTEMR/"
	  proj_folder <- "/Users/k1926273/Desktop/MASTEMR/"
	}else if(node["nodename"] == "PETES_PC"){
      pisa_data <- "C:/Users/peter/OneDrive - King\'s College London/Code/QERKCL_PISA/data/pisa/"
      base_location <- "C:/Users/peter/OneDrive - King\'s College London/Code/MASTEMR/"
	  proj_folder <- r"(C:/tmp/MASTEMR/)"
	  
	}else if(node["nodename"] == "KCLJ7J6LFC74J"){ #Richard"s Mac
	  datafolder <- r"(/Users/k1765032/Google Drive/My Drive/PISR/data/PISA/)"
	  pisa_data <- r"(/Users/k1765032/Library/CloudStorage/OneDrive-King\'sCollegeLondon/QERKCL_PISA/data/pisa/)"
	  base_location <- r"(/Users/k1765032/Library/CloudStorage/OneDrive-King\'sCollegeLondon/Peter Kemp\'s files - MASTEMR/)"
	  proj_location <- "/Users/k1765032/Library/CloudStorage/OneDrive-King\'sCollegeLondon/Peter Kemp\'s files - MASTEMR/"
	  proj_folder <- "/Users/k1765032/Library/CloudStorage/OneDrive-King\'sCollegeLondon/Peter Kemp\'s files - MASTEMR/"
	}else if(node["nodename"] == "KCL3Y7NKR3"){ #Pete"s NEW Laptop
	  datafolder <- "G:/My Drive/Kings/Code/PISR/Data/PISA/)"
	  pisa_data <- "C:/Users/k1926273/OneDrive - King\'s College London/Code/QERKCL_PISA/data/pisa/)"
	}else if(node["nodename"] == "Amys-MacBook-Air.local"){ #Pete"s NEW Laptop
	  datafolder <- r"(/Users/amyobrien/Google Drive/My Drive/Data/PISA/)"
	  loc_amy <- r"(/Users/amyobrien/Google Drive/My Drive/MASTEMR/data/)"
	}else{
	  warning("Can\'t find PC name, using default folder location")
	  datafolder <- "D:/OneDrive/KCL OneDrive/OneDrive - King\'s College London/Code/SCARI/"
	}
	
	loc_amy <- glue("{base_location}data/")
    
    source(glue("{proj_folder}MASTEMR_functions.R"))
  }
      source(glue("{proj_folder}MASTEMR_functions.R"))
      source(glue("{proj_folder}MASTEMR_setup_libs.R"))
      source(glue("{proj_folder}MASTEMR_setup.R"))
      # OpenAnalysis_load_ALL(use_cache = TRUE, 
      #                       report_cache_folder=r\'[",MASTEMR_cache,"]\',
      #                       over_write=FALSE)
\n\r```'
  
  
  return(setup_code)
}

# update @ references between files for when it's a paginated website
update_internal_links <- function(dir_path = "D:\\temp\\MASTEMR\\simple"){
  # table to store links and file names
  table <- data.frame(link = character(), file_name = character())
  
  # search through files in directory
  files <- list.files(path = dir_path, full.names = TRUE)
  for(file_path in files) {
    if(file.info(file_path)$isdir == FALSE) {
      lines <- readLines(file_path)
      message(file_path)
      
      
      for(line in lines) {
        # message(line)
        match <- str_extract_all(line, "(@.*(?=[ ]))")
        
        if (length(match) > 1 | length(match[[1]]) != 0) {
          # message(line)
          message(match)
          print(paste(match, c(basename(file_path))))
          
          table <- rbind(table, paste(match, basename(file_path)))
          
        }
      }
    }
  }
  
}

#############################
# THIS IS THE ONE THAT WORKS
#############################
# copy whole project to a temp folder and run from there to avoid
# google drive locking bug
copy_run <- function(type = "booklet", 
                     dest=NULL, src=NULL, 
                     proj_name = "MASTEMR"){

  # dest <- r'[C:\temp\TRACER]'
  # src <- r'[G:\My Drive\Kings\Code\PISR\_reports\TRACER]'
  # proj_name = "TRACER"
  
  node <- Sys.info()
  if(node["nodename"] == "PETES_PC" & is.null(dest) & is.null(src)){
    # src  <- r'[C:\Users\Peter\Google Drive\Kings\Code\MASTEMR]'
    # src  <- r'[G:\My Drive\Kings\Code\MASTEMR]'
    src  <- r'[C:\Users\peter\OneDrive - King's College London\Code\MASTEMR]'
    # dest <- r'[D:\temp\MASTEMR]'
    dest <- r'[C:\tmp\MASTEMR]'
    MASTEMR_cache <- r'[C:\tmp\MASTEMR_cache]'
  }
  if(node["nodename"] == "KCLJ7J6LFC74J" & is.null(dest) & is.null(src)){
    src  <- "/Users/k1765032/Library/CloudStorage/OneDrive-King'sCollegeLondon/DOCTR/"
    dest <- "/Users/k1765032/Documents/Teaching/STEM MA/Quantitative module/R/Temp/DOCTR/"
    MASTEMR_cache <- "/Users/k1765032/Documents/Teaching/STEM MA/Quantitative module/R/Temp/MASTEMR"
  }
  if(node["nodename"] == "KCLMLVXD9XH6P" & is.null(dest) & is.null(src)){
    src  <- "/Users/k1926273/Library/CloudStorage/OneDrive-King\'sCollegeLondon/Code/MASTEMR"
    dest <- "/Users/k1926273/Desktop/MASTEMR"
    MASTEMR_cache <- "/Users/k1926273/Desktop/MASTEMR/"
  }
  
  source(paste0(src, "/MASTEMR_setup_libs.R"))
  
  # Check if the destination folder exists
  if (dir.exists(dest)) {
    # If it does, delete it
    unlink(dest, recursive = TRUE, force = TRUE)
  }
  
  # Create the destination folder
  # dir.create(dest)

  # Get a list of all the subdirectories in the original path
  dirs <- list.dirs(path = src, recursive = TRUE, full.names = TRUE)
  
  dirs <- paste0(dest,gsub(glue(".*{proj_name}"),"",dirs)) %>% 
    subset(!grepl("_site|[.]Rproj|[.]RData|[.]user|[.]git|[.]ini|[.]quarto|[.]old|[_]freeze",
                  .)) %>%
    unique()
  
  # tmp <- as.data.frame(dirs)
  
  # Create a new directory structure at the new path
  for (d in dirs) {
    message(d)
    dir.create(file.path(d), recursive = TRUE)
  }
  
  # Get a list of all files and subfolders in the source folder
  files <- list.files(src, recursive = TRUE,  all.files=TRUE) %>%
    subset(!grepl(paste0("_site|[.]Rproj|[.]Rhistory|[.]RData|[.]user|[.]git|",
                         "[.]ini|[.]quarto|[.]old|[.]html|_files|[_]freeze|",
                         "working[_]chapters|site[_]libs|simple|index[_]files|",
                         "data[/]"),.)) %>%
    unique()
  
  # Copy each file and subfolder to the destination
  for (f in files) {
    # edit file is a chapter file
    message(paste0(dest, '/', f))
    file.copy(from = paste0(src, '/', f), to = paste0(dest, '/', f))
  }
  
  # copy over the custom index_paginated page
  # and rewrite the headers to make use of the cache for each page
  if(type=="booklet"){
    message("creating a book")
    # have replaced index with index_paginated
    # for original index see index_single.qmd
    
    #file.copy(from = paste0(src, '/index_paginated.qmd'), 
    #          to = paste0(dest, '/index.qmd'),
    #          overwrite = TRUE)

    # Rewrite the header on each file
    # for each setup block, replace with custom code
    
    #MASTEMR_cache <- "C:/temp/cache/MASTEMR/"
    # GET CODE FOR TOP OF PAGE
    setup_code <- get_setup_code()

    # read each qmd file
    fles <- list.files(paste0(dest, "/chapters/"))
    fles <- fles[grepl("[.]qmd", fles)]
    
    # rewrite each file with the new header
    walk(fles, \(f){
      # f <- "05-Introduction_to_PISA.qmd"
      # tmp <- "```{r setup}\n\rdfgesrg ewrg erg ```"
      # str_replace(tmp,
      #             "[`]{3}[{]r[ ]setup[}][\\s\\S]*[`]{3}",
      #             "***")
      
      # tst<- "```{r setup}
      # ```
      # tets
      # test
      # ```{r something}
      # ```"
      # "[`]{3}[{]r[ ]setup[}][\\s\\S]*[`]{3}",  #(?=([`]{3}))
      
      # add standard loading code to each page
      temp_file <- read_file(glue("{dest}/chapters/{f}"))
      temp_file <- str_replace(temp_file,
                               "[`]{3}[{]r[ ]setup[}][^\`]*[`]{3}",
                               setup_code)
      
      # uncomment titles
      temp_file <- str_replace(temp_file,
                               "[#][ ]title[:]",
                               "title:")
      
      # comment out explicit bibliography
      temp_file <- str_replace_all(temp_file,
                                   "bibliography:",
                                   "# bibliography:")
      
      write_file(temp_file, glue("{dest}/chapters/{f}"))
    })
    
  }
  
  # run qmd file
  library(quarto)
  
  # Check if the index_files folder is stuck and needs deleting
  if (dir.exists(paste0(dest,"/index_files"))) {
    # If it does, delete it
    unlink(paste0(dest,"/index_files"), recursive = TRUE, force = TRUE)
  }
  
  
  # pick the type of website you are rendering.
  if(type == "single"){
    message("RENDERING SINGLE")
    system(paste0('quarto.cmd render ', paste0(dest,"/index.qmd")))
    
    indx <- read_file(paste0(dest, "/_site/index.html"))
    indx_fix <- str_replace_all(indx, "src=\"chapters/index_files","src=\"index_files")
    # str_detect(indx, "src=\"chapters/index_files")
    write_file(indx_fix, paste0(dest, "/_site/index.html"))
  }
  
  if(type == "booklet"){
    message("RENDERING PAGINATED")
    setwd(dest)
    
    system(paste0('quarto render')) # for a book
    
    # fix broken cross chapter links, feature missing from quarto
    xchapter_links() # dest <> src when you want to store files in different locations

    # separate the setup into loading files and loading headers
    setwd(src)
  }
  
  message("remapping images")

  message("copying images over?!")
  
  img_dirs <- list.dirs(path = paste0(dest,"/images"), recursive = TRUE, full.names = TRUE)
  img_dirs <- str_replace_all(img_dirs, proj_name, glue("{proj_name}/_site/chapters"))
  
  # Create a new directory structure at the new path
  for (d in img_dirs) {
    dir.create(file.path(d), recursive = TRUE)
  }
  
  images <- list.files(paste0(dest,"/images"), recursive = TRUE)
  for (f in images) {
    message(paste0(dest, '/', f))
    message(paste0(dest,"/_site/chapters/images/", f))
    file.copy(from = paste0(dest,"/images/", f), 
              to = paste0(dest,"/_site/chapters/images/", f))
  }
}

# fix cross chapter hyperlinks
xchapter_links <- function(src=NULL, 
                           dest=NULL){
  message("creating cross links between chapters")
  library(rvest)
  
  # generally src and dest will be the same
  # src="C:\\temp\\MASTEMR\\_site"
  # dest="C:\\temp\\website"
  
  if(is.null(src) | is.null(dest)){
    node <- Sys.info()
    if(node["nodename"] == "KCLJ7J6LFC74J"){ #Richard's PC
      src  <- "/Users/k1765032/Documents/Teaching/STEM MA/Quantitative module/R/Temp/MASTEMR/_site"
      dest <- "/Users/k1765032/Documents/Teaching/STEM MA/Quantitative module/R/Temp/MASTEMR/_site"   
    }else if(node["nodename"] == "KCL3Y7NKR3"){ #Pete's NEW Laptop
      src  <- "C:\\temp\\MASTEMR\\_site"
      dest <- "C:\\temp\\website"
    }else if(node["nodename"] == "KCLMLVXD9XH6P"){ #Pete's mac
      src  <- "/Users/k1926273/Desktop/MASTEMR/_site"
      dest <- "/Users/k1926273/Desktop/MASTEMR/_site"
    }else if(node["nodename"] == "PETES_PC"){ #Pete's PC
      src  <- "C:\\tmp\\MASTEMR\\_site"
      dest <- "C:\\tmp\\MASTEMR\\_site"
    }
  }
  
  # dest = "C:\\temp\\MASTEMR\\_linked"
  # src = "C:\\temp\\MASTEMR\\_site"
  
  # get all HTML pages in the folder
  pages <- list.files(paste0(src), 
                     include.dirs = TRUE,
                     full.names = TRUE,
                     recursive = TRUE)
  pages <- pages[grepl("[.]html", pages)]

  # page, anchor
  anchor_origins <- data.frame()
  anchor_links <- data.frame()
  
  # search for all anchors and turn into dataframe
  anchor_origins <- map_dfr(pages, \(page){
    message(">>> ", page)
    # page <- "C:/temp/MASTEMR/_site/chapters/10-Correlation_and_regression.html"
    # page <- r"[C:\tmp\MASTEMR\_site/chapters/02-2-Intro_to_analysis_software.html]"
    # page <- r"[C:\\tmp\\MASTEMR\\_site/chapters/01-Intro_to_quant_methods.html]"
    # page <- r"[C:\temp\MASTEMR\_site/chapters/A5-Self_Study_Tasks.html]"
    #data-anchor-id="sec-QANDA"
    
    # read page
    temp_file <- read_file(page)

    ttls <- read_html(temp_file) |> 
      html_elements("h1:not(#toc-title):not(.title), 
                     h2:not(#toc-title):not(.title),
                     h3:not(#toc-title):not(.title),
                     h4:not(#toc-title):not(.title)") |> 
      html_text() |> 
      trimws() |>
      #str_subset("^[0-9]{1}[0-9]?[.]?") |>
      # tail(1) |>
      str_remove_all("^[0-9]*[.]?[0-9]?[0-9]?") |>
      trimws()
    
    lnks <- read_html(temp_file) |> 
      html_elements("section, .level") |>
      html_attr("id")
    
    paste(ttls, " - ", lnks)
  
    #lnks <- str_extract_all(temp_file, '(?<=(<section id[=]\"))[^\"]*(?=(\" class=\"level))')[[1]] %>% 
    # str_squish()

    message(page)
    message(paste(lnks, collapse = " | "))
    message(paste(ttls, collapse = " | "))
    
    if(length(lnks) == 0){
      data.frame(name=NULL,
                 links=NULL)
    }else{
      data.frame(name=page,
                 links=lnks,
                 titles=ttls)
    }
  })
  
  # find unresolved links in pages
  anchor_links <- map_dfr(pages, \(page){
    #page <- "C:/temp/MASTEMR/_site/chapters/02-1-Intro_to_analysis_software.html"
    
    temp_file <- read_file(page)
    
    # extract all the links on the page
    lnks <- str_extract_all(temp_file, "(?<=[<]strong[>][?][@])[^<]*")[[1]]
    
    message(page, "\n", paste(lnks, collapse = " | "))
    
    if(length(lnks) == 0){
      data.frame(name=NULL,
                 links=NULL)
    }else{
      data.frame(name=page,
               links=lnks)
    }

  })
  
  # warning for any anchors linked but missing from origins
  if(setdiff(anchor_links$links, anchor_origins$links) %>% length() > 0){
    warning("links MISSING for: ", 
            paste(setdiff(anchor_links$links, anchor_origins$links),
                  collapse=" | "))
  }else{
    warning("All missing links have been found")
  }
  
  
  # add row numbers to each group of page name
  # this is so we can update the already updated page
  # page when rnum > 1
  anchor_links <- anchor_links %>% 
    group_by(name) %>%
    mutate(rnum = row_number())
  
  # fix missing cross chapter links
  message("writing new chapter links")
  tmp <- map(1:nrow(anchor_links), \(n){
    
    # breaks on this?
    # C:\temp\MASTEMR\_site/chapters/03-Differing_performance_in_STEM.html
    
    # n = 2
    lnk <- anchor_links[n,2] %>% pull(links)
    
    # number of edit for a page
    edit_num <- anchor_links[n,3] %>% pull(rnum)
    
    page_from <- anchor_links[n,1] %>% pull(name)
    page_to <- anchor_origins %>% 
      filter(links == lnk) %>% 
      pull(name) %>%
      str_replace(".*_site", "..")
    
    title <- anchor_origins %>% 
      filter(links == lnk) %>% 
      pull(titles)
    
    message(paste(n, ":" , edit_num, ": ", title, lnk, page_from, page_to, collapse = "\n"))
    
    # href="../chapters/04-Presentations.html"
    
    # if dest and source are different then we need to
    # use the latest version of the file from dest
    if((dest != src) & (edit_num > 1)){
      # use the page that is already being updated
      # grepl(src,page_from)
      
      src_regex <- str_replace_all(src, "\\\\", "\\\\\\\\")
      dest_regex <- str_replace_all(dest, "\\\\", "\\\\\\\\")
      
      message("additional updates will be made to this page ", str_replace(page_from, src_regex, dest_regex))
      temp_file <- read_file(str_replace(page_from, src_regex, dest_regex))
    }else{
      temp_file <- read_file(page_from)
    }
    
    # grep("[@]sec-loading-computer", temp_file)
    
    # add §
    temp_file <- str_replace_all(temp_file, 
                    glue('[<]strong[>][?][@]{lnk}[<][/]strong[>]'),
                    glue('<a href="{page_to}#{lnk}">\u00A7{title}</a>'))
                    #glue('<strong><a href="{page_to}#{lnk}">\u00A7{title}</a></strong>'))
    
    # create folder(s) if they don't exist
    dir <- file.path(paste0(dest, "\\chapters\\"))
    if (!dir.exists(dir)) dir.create(dir, recursive = TRUE)
    
    write_file(temp_file, 
              paste0(dest,
                     substr(page_from,
                     nchar(src)+1,
                     nchar(page_from))))
  })
}

# copy all the chapters into a format that can be rendered 
copy_clean_chapters <- function(dest=r'[G:\My Drive\Kings\Code\MASTEMR\simple\]', 
                                src=r'[G:\My Drive\Kings\Code\MASTEMR\working_chapters\]'){
  
  # src  <- r'[G:\My Drive\Kings\Code\MASTEMR\working_chapters\]'
  # dest  <- r'[G:\My Drive\Kings\Code\MASTEMR\simple\]'
  
  # Check if the destination folder exists
  if (dir.exists(dest)) {
    # If it does, delete it
    unlink(dest, recursive = TRUE, force = TRUE)
  }
  
  # Create the destination folder
  dir.create(dest)
  
  # Get a list of all files and subfolders in the source folder
  files <- list.files(src, recursive = TRUE) %>%
    subset(!grepl("_site|[.]Rproj[.]user|[.]git|[.]html|_files|[.]ini",.)) %>%
    unique()
  
  # Copy each file and subfolder to the destination
  for (f in files) {
    message( paste0(dest, '\\', str_replace(f,"^_", "")))
    file.copy(from = paste0(src, '/', f), 
              to = paste0(dest, '\\', str_replace(f,"^_", "")))
  }
  
  # for each setup block, replace with custom code
  
  # GET CODE FOR TOP OF PAGE
  setup_code <- get_setup_code()

  # read each qmd file
  fles <- list.files(dest)
  fles <- fles[grepl("[.]qmd", fles)]
  
  # rewrite each file with the new header
  map(fles, \(f){
    # f <- "02-4-Intro_to_graphs.qmd"
    # tmp <- "```{r setup}\n\rdfgesrg ewrg erg ```"
    # str_replace(tmp,
    #             "[`]{3}[{]r[ ]setup[}][\\s\\S]*[`]{3}",
    #             "***")
    
    # add standard loading code to each page
    temp_file <- read_file(glue("{dest}{f}"))
    temp_file <- str_replace(temp_file,
                             "[`]{3}[{]r[ ]setup[}][\\s\\S]*[`]{3}",
                             setup_code)
    
    # uncomment titles
    temp_file <- str_replace(temp_file,
                             "[#][ ]title[:]",
                             "title:")
    
    # comment out explicit bibliography
    temp_file <- str_replace_all(temp_file,
                             "bibliography:",
                             "# bibliography:")
    
    write_file(temp_file, glue("{dest}{f}"))
    return(NULL)
  })
  
}

# conduct a ttest across countries on a specified column
ttest_by_country <- function(data, column = PV1MATH){
  
  # tmp <- ttest_by_country(PISA_2018, PV1MATH)
  # column <- sym("PV1MATH")
  # data <- PISA_2018
  # Mathgendergap <- tmp
  
  # work out which countries have full 30+ datasets for this ttest
  countries <- data %>% ungroup() %>%
    filter(!is.na({{column}})) %>%    # {{column}} allows you to change the field of focus
    select(CNT, ST004D01T, {{column}}) %>%
    group_by(CNT) %>%
    filter(n() > 30) %>%
    pull(CNT) %>%  # the pull command returns the column as a vector, not a table
    unique()
  
  # list the countries that don't meet that criteria
  message("dropping: ", setdiff(unique(data$CNT), countries), " as too few entries for ttest")
  
  # reduce the dataset to only those countries with 30+ entries
  data <- data %>% 
    filter(CNT %in% countries)
  
  # for each country in this new dataset perform a set of calculations
  test_result <- map_df(unique(data$CNT), 
                        function(x){
                          
                          # make a subset of the data just for that country
                          df <- data %>% filter(CNT == x)
                          
                          # get the results pull({{column}}) for females and males as two separate vectors
                          f_data <- df %>% filter(ST004D01T == "Female") %>% pull({{column}})
                          m_data <- df %>% filter(ST004D01T == "Male") %>% pull({{column}})
                          
                          # tell us the number of results
                          message(x, " f:", length(f_data), " m:", length(m_data))
                          
                          # work out the means of each vector
                          f_mean <- mean(f_data)
                          m_mean <- mean(m_data)
                          
                          t.test(m_data, f_data) %>%  # conduct a ttest on the male and female results
                            tidy() %>%      # convert the ttest result into a dataframe
                            mutate(CNT = x,           # add columns to record the country
                                   f_mean = f_mean,   # the mean female grade
                                   m_mean = m_mean,   # the mean male grade
                                   gender_diff = m_mean - f_mean,  # the difference between the two
                                   prop_male = length(m_data) / (length(m_data) + length(f_data)))
                          # and the proportion who are male in the dataset
                        })
  return(test_result)
}

plot_ttest_by_country <- function(data, column = "PV1MATH"){
  
  # Mathgendergap <- ttest_by_country(PISA_2018, PV1MATH)
  
  ggplot(Mathgendergap %>% mutate(sig = p.value < 0.05),
         aes(x=reorder(CNT, gender_diff), y=gender_diff, colour=sig))+
    geom_point(aes(size = prop_male)) +  
    geom_hline(yintercept = 0, lty=2) +  # add a line on 0
    coord_flip() +     # rotate the graph
    xlab("country") +
    ylab("mean(male - female)") +
    ggtitle(paste("gender differences for:", column)) +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5,
                                     hjust=1, size=5))
}

#clean up percentage numbers
printper <- function(num, d=1){
  if(is.character(num)){
    num <- as.numeric(num)
  }
  
  return(formatC(round(num, digits=d), format="f", digits=d))
}

# print percentage as when it's a fraction
printper0 <- function(num, d=1){
  if(is.character(num)){
    num <- as.numeric(num)
  }
  
  return(round(100 * num, digits=d))
}

# create a grepl that returns NA values with * set, otherwise it returns NA
greplna <- function(data, reg="*", var="Discount code"){
  if(reg == "*"){
    tmp <- grepl("*", as.list(data[var])[[1]]) | is.na(as.list(data[var])[[1]])
  }else{
    tmp <- grepl(reg, as.list(data[var])[[1]])
  }
  return(tmp)
}

# save all the objects to a cache folder
save_cache_all_objects <- function(report_cache_folder = r"[D:\Data\EdR\cache\computing22\]", 
                                   method="feather"){
  # https://stackoverflow.com/questions/77055120/error-when-using-get-within-a-dplyr-mutate-statement-in-r
  # fetch all large dataframes
  
  message("getting objects to store in:", report_cache_folder)
  
  # get data_items
  data_items <- data.frame(name = ls(envir=.GlobalEnv),
                           class = paste(sapply(mget(ls(envir=.GlobalEnv), envir=.GlobalEnv), class)),
                           size = sapply(mget(ls(envir=.GlobalEnv), envir=.GlobalEnv), object.size)) %>%
    filter(class != "function") %>%
    dplyr::mutate(dataframe = 
                    grepl("data[.]frame", class) & !grepl("xtable", class))
  
  # print(data_items)
  
  # load different types of objects
  data_tables <- data_items %>% filter(dataframe)
  data_other <- data_items %>% filter(!dataframe)
  
  # save parquet files
  tmp <- map(data_tables$name, \(tbl){
    
    # switch methods. feather 2.5x faster
    if(method=="p" | method=="parquet"){
      message("writing: ", tbl, " as .parquet")
      write_parquet(get(tbl),
                    paste0(report_cache_folder, tbl, ".parquet"))
    }else{
      message("writing: ", tbl, " as .feather")
      write_feather(get(tbl),
                    paste0(report_cache_folder, tbl, ".feather"))
    }
  })
  
  message("Writing .RData")
  #save other objects
  save(list=data_other$name, file=paste0(report_cache_folder, "cache.RData"))
  
}

# load all items from a cache folder
load_cache_all_objects <- function(report_cache_folder=r"[D:\Data\EdR\cache\computing22\]", 
                                   method="p",
                                   over_write=FALSE){
  #TODO: implement the over_write function, so that any existing objects are not overwritten by th cache
  # read contents of folder
  fles <- list.files(report_cache_folder)
  
  if(method == "p"){
    # load parquet files  
    parquets <- fles[grepl("[.]parquet", fles)]
    tmp <- map(parquets, \(tbl){
      message("reading: ", tbl)
      
      assign(gsub("[.]parquet", "", tbl), 
             read_parquet(paste0(report_cache_folder, tbl)), 
             envir = .GlobalEnv)
      return(NULL)
    })    
  }else{
    # load feather files  
    feathers <- fles[grepl("[.]feather", fles)]
    tmp <- map(feathers, \(tbl){
      message("reading: ", tbl)
      
      assign(gsub("[.]feather", "", tbl), 
             read_feather(paste0(report_cache_folder, tbl)), 
             envir = .GlobalEnv)
      return(NULL)
    })  
    
  }
  
  
  # load other objects
  if(sum(grepl("[.]RData", fles)) == 1){
    message("Reading .RData file")
    load(paste0(report_cache_folder, "cache.RData"), envir = .GlobalEnv)
  }
}

# LOAD ALL THE VARIABLES
OpenAnalysis_load_ALL <- function(use_cache = TRUE, 
                                  report_cache_folder=r"[D:\Data\EdR\cache\computing22\]",
                                  over_write=FALSE){
  #source(paste0(basefolder, "_reports/TRACER/TRACER-setup.R"))
  #source(paste0(basefolder, "code/DfE_setup.R"))
  # use_cache=FALSE
  
  if(use_cache){
    message("LOAD CACHED")
    
    load_cache_all_objects(report_cache_folder=report_cache_folder, 
                           method="feather",
                           over_write=over_write)
  }else{
    message("CREATING NEW CACHE")
    
    source(paste0(proj_folder,'MASTEMR_setup.R'))
   
    save_cache_all_objects(report_cache_folder=report_cache_folder, method="feather")
  }
}

# copy the chapters across to a new folder and put into format for them to be rendered
copy_paginated <- function(src = r"(G:\My Drive\Kings\Code\MASTEMR\chapters\)", 
                           dest= r"(G:\My Drive\Kings\Code\MASTEMR\pages\)"){
  
  # see copy_clean_chapters()
  
  # get the qmd files
  fles <- list.files(src)
  fles <- fles[grepl("[.]qmd", fles)]
  
  # replace the setup block
  
  setup_code <- get_setup_code()
  
  
}
