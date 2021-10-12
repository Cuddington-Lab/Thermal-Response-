setwd("~/Desktop")
#download worldclim maps
X00<-getData("worldclim", var="bio", res=0.5,lat=90,lon=-180)[[1]] 
X01<-getData("worldclim", var="bio", res=0.5,lat=90,lon=-145)[[1]] 
X02<-getData("worldclim", var="bio", res=0.5,lat=90,lon=-110)[[1]]
X03<-getData("worldclim", var="bio", res=0.5,lat=90,lon=-70)[[1]]
X04<-getData("worldclim", var="bio", res=0.5,lat=90,lon=-50)[[1]]
X10<-getData("worldclim", var="bio", res=0.5,lat=55,lon=-180)[[1]]
X11<-getData("worldclim", var="bio", res=0.5,lat=55,lon=-145)[[1]] 
X12<-getData("worldclim", var="bio", res=0.5,lat=55,lon=-110)[[1]] 
X13<-getData("worldclim", var="bio", res=0.5,lat=55,lon=-70)[[1]] 
X14<-getData("worldclim", var="bio", res=0.5,lat=55,lon=-50)[[1]] 
X22<-getData("worldclim", var="bio", res=0.5,lat=25,lon=-110)[[1]]
X23<-getData("worldclim", var="bio", res=0.5,lat=25,lon=-70)[[1]]
#merge all the puzzle pieces
NA.map<-merge(X00,X01,X02,X03,
              X04,X10,X11,X12,
              X13,X14,X22,X23)
#fix the extent
NA.map<-crop(NA.map, extent(-168,-52,25,85))
#fix the decimals
NA.map=NA.map/10
#double check it looks alright
plot(NA.map)