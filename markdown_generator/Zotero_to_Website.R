
this.dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(this.dir)

library(tidyverse)


Zotero_Format <- read_csv("Personal Papers for Website.csv")

website_order<-c("pub_date", "title", "venue",	"excerpt","citation", "url_slug", "paper_url", "slides_url", "category"
)

Website_Format <- read_csv("Personal Papers for Website.csv")  %>%
  select("Publication Year", Title, "Publication Title", "Notes", "Url") %>% 
#The TSV needs to have the following columns: pub_date, title, venue, excerpt, citation, site_url, and paper_url, with a header at the top. \
  
  rename(

    pub_date = "Publication Year",
    title = Title,
    venue = "Publication Title",
    excerpt = "Notes", 
    paper_url = "Url"
         ) %>% 
  mutate(citation = "",
        url_slug = round(runif(n(), min=1, max=90000)),
        slides_url = "",
        category = "manuscripts",
        ) %>% 
  
  #needed for script for now
  mutate(pub_date = ymd(paste0(pub_date, "-01-01"))) %>%   


  select("pub_date", "title", "venue",	"excerpt","citation", "url_slug", "paper_url", "slides_url", "category")

# write_tsv(Website_Format, file = "publications.tsv", col_names = TRUE)
write_csv(Website_Format, file = "publications.csv", col_names = TRUE)

system("python3 publications.py publications.csv")
