#' @include Downloader.R
DownloaderNafarroa<-R6Class("SingletonContainer",inherit=Singleton,portable=FALSE,
                           public=list(
                             initialize=function(...)
                             {
                               Class<<-R6Class("DownloaderNafarroa",portable=F,
                                               inherit=Downloader,
                                               public=list(
                                                 getHour=function(pStation,pDate)
                                                 {
                                                   codEst=substr(pStation$getCode(),3,5);
                                                   url<-url(paste("http://meteo.navarra.es/download/estacion_datos.cfm?idestacion=",codEst,"&p_10=7&p_10=6&p_10=1&fecha_desde=",pDate$printDateNoHourNonStandardDash(),"&fecha_hasta=",pDate$getDay()+1,"/",pDate$getMonth(),"/",pDate$getYear(),"&dl=csv",sep=""));

                                                     tryCatch({
                                                       readVector<-list();
                                                       response=read.csv(url,header=F,skip=4);
                                                       if(!is.null(response)){
                                                         for(i in 1:6)
                                                         {
                                                           dataRow<-response[(pDate$getHour()*6)+i,];
                                                           date=Date$new(pDate$getYear(),pDate$getMonth(),pDate$getDay(),pDate$getHour(),10*i-10);
                                                           direction<-as.numeric(dataRow$V2);
                                                           speed<-as.numeric(dataRow$V3);
                                                           temperature<-as.numeric(dataRow$V4);
                                                           if(!(speed=="- -" || direction=="- -" || temperature=="- -"))
                                                           {
                                                             newRead<-Read$new(date,speed,direction,temperature);
                                                             readVector=c(readVector,newRead);
                                                           }
                                                         }
                                                         return(super$commitOrError(pStation,readVector))
                                                       }else return(null);
                                                        },
                                                       error=function(e){
                                                         print(e);
                                                       })
                                                 }
                                               )
                               )
                               super$initialize();
                             }
                           )
)$new();