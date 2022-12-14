## data import and variable selection
tdhs <- read_stata("use your data file path here")
vars <- c("hv001", "hv002", "hv005", "hv021", "hv226", "hv241")   
newtdhs <- tdhs[vars]   #new dataset
head(newtdhs)

## survey weight & settings
newtdhs$wgt <- newtdhs$hv005/1000000   #to calculate household weight

## define variable: cooking fuel (cf)
table(newtdhs$hv226)
newtdhs$cf[newtdhs$hv226=="1"] <- 0
newtdhs$cf[newtdhs$hv226=="12"] <- 0
newtdhs$cf[newtdhs$hv226=="5"] <- 1
newtdhs$cf[newtdhs$hv226=="7"] <- 1
newtdhs$cf[newtdhs$hv226=="8"] <- 1
newtdhs$cf[newtdhs$hv226=="9"] <- 1
newtdhs$cf[newtdhs$hv226=="11"] <- 1
newtdhs$cf[newtdhs$hv226=="95"] <- "NA"
newtdhs$cf[newtdhs$hv226=="96"] <- "NA"
newtdhs$cf_label <- ordered(newtdhs$cf,
                      levels = c(0,1),
                      labels = c("No Smoke-producing Fuels", "Smoke-producing Feuls"))
table(newtdhs$cf)

## define variable: cooking place (cp)
table(newtdhs$hv241)
newtdhs$cp[newtdhs$hv241=="3"] <- 0
newtdhs$cp[newtdhs$hv241=="1"] <- 1
newtdhs$cp[newtdhs$hv241=="2"] <- 1
newtdhs$cp[newtdhs$hv241=="6"] <- "NA"
newtdhs$cp_label <- ordered(newtdhs$cp,
                       levels = c(0,1),
                       labels = c("Outdoor Cooking", "Indoor Cooking"))
table(newtdhs$cp)

## define variable: smoke exposure risk (ser)
newtdhs$ser[newtdhs$cf=="0" & newtdhs$cp=="0"] <- 4
newtdhs$ser[newtdhs$cf=="0" & newtdhs$cp=="1"] <- 3
newtdhs$ser[newtdhs$cf=="1" & newtdhs$cp=="0"] <- 2
newtdhs$ser[newtdhs$cf=="1" & newtdhs$cp=="1"] <- 1
table(newtdhs$ser)
newtdhs$ser_label <- ordered(newtdhs$ser,
                             levels = c(4,3,2,1),
                             labels = c("Very Low SER", "Low SER", "Medium SER", "High SER"))
ftable(xtabs(~ cf_label + cp_label, data = newtdhs))
table(newtdhs$ser_label)
