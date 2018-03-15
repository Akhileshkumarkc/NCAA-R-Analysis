TourneyCompactResults <- read_csv("C:/Akhilesh Graduate studies/Sem 4/DSR/DataScienceR/Mid Term Project/TourneyCompactResults.csv")
RegularSeasonDetailedResults <- read_csv("C:/Akhilesh Graduate studies/Sem 4/DSR/DataScienceR/Mid Term Project/RegularSeasonDetailedResults.csv")

myData <- RegularSeasonDetailedResults

myDataShort = head(mydata,2)



winColumns = c("Season" ,"Daynum", "Wteam"  ,"Wscore" , "Wloc" ,  "Numot",  "Wfgm" ,  "Wfga" ,  "Wfgm3",  "Wfga3",  "Wftm",  
               "Wfta" ,  "Wor"  ,  "Wdr"  ,  "Wast" ,  "Wto" ,    "Wstl"  , "Wblk",   "Wpf")

lostColumns =  c("Season" ,"Daynum", "Lteam"  , "Lscore", "Wloc" ,  "Numot",  "Lfgm",  "Lfga",  "Lfgm3", "Lfga3",   "Lftm",  
                 "Lfta" ,   "Lor"  ,  "Ldr"  ,  "Last" ,  "Lto",    "Lstl", "Lblk",   "Lpf")
combined = c ("Season" ,"Daynum", "team"  ,"score" , "wloc" ,  "Numot",  "fgm" ,  "fga" ,  "fgm3",  "fga3",  "ftm",  
              "fta" ,  "or"  ,  "dr"  ,  "ast" ,  "to" ,    "stl"  , "blk",   "pf")

myDataWin = myDataShort[winColumns]
myDataLose = myDataShort[lostColumns]
colnames(myDataWin) = combined
colnames(myDataLose) = combined
combinedData = rbind(myDataWin,myDataLose)

dim(combinedData)
#######################
#Data Wrangling4
#######################################
winColumns = c("Season" ,"Daynum", "Wteam"  ,"Wscore" , "Wloc" ,  "Numot",  "Wfgm" ,  "Wfga" ,  "Wfgm3",  "Wfga3",  "Wftm",  
               "Wfta" ,  "Wor"  ,  "Wdr"  ,  "Wast" ,  "Wto" ,    "Wstl"  , "Wblk",   "Wpf")

lostColumns =  c("Season" ,"Daynum", "Lteam"  , "Lscore", "Wloc" ,  "Numot",  "Lfgm",  "Lfga",  "Lfgm3", "Lfga3",   "Lftm",  
                 "Lfta" ,   "Lor"  ,  "Ldr"  ,  "Last" ,  "Lto",    "Lstl", "Lblk",   "Lpf")

combined = c ("Season" ,"Daynum", "team"  ,"score" , "wloc" ,  "Numot",  "fgm" ,  "fga" ,  "fgm3",  "fga3",  "ftm",  
              "fta" ,  "or"  ,  "dr"  ,  "ast" ,  "to" ,    "stl"  , "blk",   "pf")

myDataWin = myData[winColumns]
myDataLose = myData[lostColumns]

colnames(myDataWin) = combined
colnames(myDataLose) = combined
combinedData = rbind(myDataWin,myDataLose)
dim(combinedData)

combinedAggrData <- aggregate.data.frame(
  combinedData[,-c(1,2,3,5)],by = list(combinedData$Season,combinedData$team),FUN = mean)

finalCombined = c ("Season", "team"  ,"score",  "Numot",  "fgm" ,  "fga" ,  "fgm3",  "fga3",  "ftm",  
                   "fta" ,  "or"  ,  "dr"  ,  "ast" ,  "to" ,    "stl"  , "blk",   "pf")

colnames(combinedAggrData) = finalCombined

summary(combinedAggrData)
########################
# Clustering
###########################
combinedAggrDataFrame = data.frame(model.matrix(~., data=combinedAggrData)[,-1])
head(combinedAggrDataFrame)
# load the data into cluster then 
myDataCluster = combinedAggrDataFrame
myDataCluster[,c(1:2)]<-NULL
myDataclusterScale = scale(myDataCluster)
myDataclusterScale

# euclidean distance
myDataClusterDistEuclMM = dist(myDataclusterScale, method = "euclidian")
# Cluster using Hclust
fitMMEucl = hclust(d=myDataClusterDistEuclMM,method="ward.D2")
plot(fitMMEucl, labels = FALSE)
#unstaged
