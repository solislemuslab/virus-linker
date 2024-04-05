##### Data #####
get_df = function(file, out_name = "clean_data"){
  # Read raw data set
  df_initial = read.table(file,
                           header = TRUE, 
                           sep = "\n", 
                           stringsAsFactors = FALSE)
  
  # Change it into data frame
  colnames(df_initial) = "Initial"
  aa = gsub("\\s+", ",", df_initial$Initial)
  aa = gsub("/", "", aa)
  split_data = str_split(aa, ",")
  df = data.frame(do.call(rbind, split_data), 
                  stringsAsFactors = FALSE) 
  
  # Clean the data frame
  df = df %>% 
    mutate(atom1_name = paste(X3, X2, X4, X1, sep="_"),
           atom2_name = paste(X7, X6, X8, X5, sep="_"))

  df = df[, -c(2:4, 6:9)]
  colnames(df)[1:3] = c("atom1", "atom2", "distance")
  
  # df$distance = 1 / as.numeric(df$distance)
  write.csv(df, paste0(out_name, ".csv"), row.names = F)
}



# data.frame(c(df$atom1, df$atom2), c(df$atom1_name, df$atom2_name)) -> aa
# aa[!duplicated(aa),] -> bb
# cc = data.frame(do.call(rbind, bb[,2] %>% str_split("_")))
# bb[,3] = paste(cc[,2], cc[,3], sep="_")
# bb[!duplicated(bb[,c(1,3)]),] -> dd
