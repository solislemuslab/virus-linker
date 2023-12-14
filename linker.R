library(tidyverse)

##### Data #####
get_df = function(file){
  df_initial <- read.table(file,
                           header = TRUE, 
                           sep = "\n", 
                           stringsAsFactors = FALSE)
  colnames(df_initial) = "Initial"
  aa = gsub("\\s+", ",", df_initial$Initial)
  aa = gsub("/", "", aa)
  split_data = str_split(aa, ",")
  df = data.frame(do.call(rbind, split_data), 
                  stringsAsFactors = FALSE) %>% 
    mutate(atom1_name = paste(X2, X3, X4, sep="_"),
           atom2_name = paste(X6, X7, X8, sep="_"),)
  
  df = df[, -c(2:4, 6:9)]
  colnames(df)[1:3] = c("atom1", "atom2", "distance")
  write.csv(df, "data_small_clean.csv", row.names = F)
}

get_df("./data_small.txt")
df = read.csv("./data_small_clean.csv")
# df$distance = 1/df$distance



##### Visualization #####
library(ggraph)
library(igraph)

data = df
data$distance = 1/data$distance

edge_list <- data %>%
  select(atom1_name, atom2_name, distance)

graph <- graph_from_data_frame(edge_list, directed = FALSE)

E(graph)$width = edge_list$distance
E(graph)$color = if_else(data$atom2=="B", "BB", "BC")

unique_atoms_B = unique(c(edge_list$atom1_name[data$atom1=="B"], 
                          edge_list$atom2_name[data$atom2=="B"]))

unique_atoms_C = unique(c(edge_list$atom1_name[data$atom1=="C"], 
                          edge_list$atom2_name[data$atom2=="C"]))

bb = 1
cc = 1
xx = c()
yy = c()
for (i in 1:length(V(graph)$name)){
  if (V(graph)$name[i] %in% unique_atoms_B){
    xx = c(xx, bb)
    yy = c(yy, 10)
    bb = bb + 5 
  } else{
    xx = c(xx, cc)
    yy = c(yy, 1)
    cc = cc + 5
  }
}

# V(graph)$x <- match(V(graph)$name, unique_atoms)
V(graph)$x <- xx

# V(graph)$y <- ifelse(V(graph)$name %in% edge_list$atom1_name, 1, 2)
V(graph)$y <- yy

p = ggraph(graph, layout = 'manual', x = V(graph)$x, y = V(graph)$y) +
  geom_edge_arc(aes(alpha = width, color = factor(color)), 
                strength = 0.2) + 
  geom_node_point(shape = 19, size = 1) +
  geom_node_text(aes(label = name),
                 vjust = 1.5,
                 hjust = 0.5,
                 size = 2.5,
                 angle = -90,
                 repel = T) +
  scale_edge_color_manual(values = c("tomato", "royalblue"), 
                          name = "Type") 
  

p
