> for(i in 1:nrow(a))
+ {
+ val=a[i,];
+ dbGetQuery(con,paste("INSERT INTO ESTACION (ES_COD,PR_COD,ES_UTMX,ES_UTMY,ES_NOMBRE,ES_ALTITUD,ES_ALTURA_MEDICION) VALUES ('",paste(val$ES_COD,val$PR_COD,val$ES_UTMX,val$ES_UTMY,val$ES_NOMBRE,val$ES_ALTITUD,val$ES_ALTURA,sep="','"),"')",sep=""));
+ }