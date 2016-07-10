if (!"AnomalyDetection" %in% installed.packages()) {
  install.packages("devtools")
  devtools::install_github("twitter/AnomalyDetection")
}
