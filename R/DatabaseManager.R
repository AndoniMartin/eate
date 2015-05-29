#' @include Singleton.R
DatabaseManager<-R6Class("SingletonContainer",
                         portable=FALSE,
                         inherit=Singleton,
                         public=list(
                           initialize=function(...)
                           {
                             Class<<-R6Class("DatabaseManager",
                                             private=list(
                                               connector="SQliteConnection",
                                               prepareReadSaveSentence=function(pStation,pRead){
                                                 return(paste(paste("INSERT INTO LECTURA(LE_FECHA,LE_VELOCIDAD,LE_DIRECCION,LE_TEMPERATURA,ES_COD) VALUES ('",
                                                                    paste(pRead$getDate()$printDate(),pRead$getSpeed(),pRead$getDirection(),pRead$getTemperature(),pStation$getCode(),sep="','"),
                                                                    "')",sep="")
                                                 ));
                                               },
                                               selectDownloader=function(pProvince)
                                               {
                                                 if(pProvince=="1" || pProvince=="3")
                                                 {
                                                   return(DownloaderEuskadi$getInstance());
                                                 }
                                                 else
                                                 {
                                                   if(pProvince=="4")
                                                   {
                                                     return(DownloaderRioja$getInstance());
                                                   }
                                                   else
                                                     return(NULL);
                                                 }
                                               },
                                               prepareHourLoadSentence=function(pStation,pDate)
                                               {
                                                 return(paste("SELECT * FROM HORA WHERE HO_FECHA='",pDate$printDateNoMinutes(),"' AND ES_COD='",pStation$getCode(),"'",sep=""));
                                               },
                                               prepareHourSaveSentence=function(pStation,pHour)
                                               {
                                                 return(paste("INSERT INTO HORA (HO_VELOCIDAD_MEDIA,HO_DIRECCION_MEDIA,HO_VELOCIDAD_MAXIMA,HO_VELOCIDAD_MINIMA,HO_TEMPERATURA_MAXIMA,HO_TEMPERATURA_MEDIA,HO_TEMPERATURA_MINIMA,HO_FECHA,ES_COD) VALUES('",
                                                              paste(pHour$getMeanSpeed(),pHour$getDirection(),pHour$getMaxiumSpeed(),pHour$getMiniumSpeed(),pHour$getMaxiumTemperature(),pHour$getMeanTemperature(),pHour$getMiniumTemperature(),pHour$getDate()$printDateNoMinutes(),pStation$getCode(),sep="','"),
                                                              "')",sep="")
                                                 );
                                                 
                                               },
                                               prepareStationListLoadSentence=function()
                                               {
                                                 return("SELECT * FROM ESTACION");
                                               },
                                               executeSentence=function(pSentence)
                                               {
                                                 tryCatch(result<-dbGetQuery(private$connector,pSentence),error=function(e)
                                                 {
                                                   print("SQLite error:"); 
                                                   print(e);
                                                   print(paste("Sentencia:",pSentence));
                                                   return(e)
                                                 },
                                                 finally=function(result){return(result)}
                                                 );
                                               }
                                             ),
                                             public=list(
                                               initialize=function()
                                               {
                                                 path="/home/andoni/Dropbox/tfg/Proyecto/Eate/database/database.db";
                                                 private$connector=dbConnect(RSQLite::SQLite(),dbname=path);
                                               },
                                               saveRead= function(pStation,pRead)
                                               {
                                                 sentence<-private$prepareReadSaveSentence(pStation,pRead);
                                                 private$executeSentence(sentence);
                                                 #TODO: Comprobar errores
                                               },
                                               saveReadList=function(pStation,pReadList)
                                               {
                                                 for(i in 1:length(pReadList))
                                                 {
                                                   DatabaseManager$getInstance()$saveRead(pStation,pReadList[[i]]);
                                                 }
                                                 #TODO: Comprobar errores
                                               },
                                               saveHour=function(pStation,pHour)
                                               {
                                                 sentence<-private$prepareHourSaveSentence(pStation,pHour);
                                                 private$executeSentence(sentence);
                                                 #TODO: Comprobar errores
                                                 
                                               },
                                               getStationList=function()
                                               {
                                                 stations=list();
                                                 sentence<-private$prepareStationListLoadSentence();
                                                 databaseOutput<-private$executeSentence(sentence);
                                                 
                                                 for(i in 1:nrow(databaseOutput))
                                                 {                                                     
                                                   code=databaseOutput[i,]$ES_COD;
                                                   name=databaseOutput[i,]$ES_NOMBRE;
                                                   elevation=databaseOutput[i,]$ES_ALTITUD;
                                                   height=databaseOutput[i,]$ES_ALTURA_MEDICION;
                                                   province=databaseOutput[i,]$PR_COD;
                                                   print(databaseOutput[i,]);
                                                   print(province);
                                                   downloader=private$selectDownloader(province);
                                                   
                                                   station=Station$new(code,name,elevation,height,province,downloader);
                                                   stations=c(stations,
                                                              station);
                                                 };
                                                 return(stations);
                                               },
                                               getHour=function(pStation,pDate)
                                               {
                                                 sentence=private$prepareHourLoadSentence(pStation,pDate);
                                                 databaseOutput=private$executeSentence(sentence);
                                                 if(nrow(databaseOutput)==0)
                                                 {
                                                   databaseOutput=NULL;
                                                 }
                                                 else
                                                 {
                                                   databaseOutput=Hour$new(databaseOutput[[2]],databaseOutput[[4]],databaseOutput[[5]],databaseOutput[[7]],databaseOutput[[6]],databaseOutput[[8]],databaseOutput[[3]],pDate);
                                                 }
                                                 return(databaseOutput);
                                               }
                                             )
                             )
                             super$initialize(...);
                           }
                         )
)$new()