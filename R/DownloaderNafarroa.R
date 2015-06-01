#' @include Downloader.R
DownloaderEuskadi<-R6Class("SingletonContainer",inherit=Singleton,portable=FALSE,
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
                                                       response=read.csv(url,header=F,skip=4);
                                                       if(!is.null(response)){
                                                         for(i in 1:6)
                                                         {
                                                           row<-response[pDate$getHour()*6+i];
                                                           
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