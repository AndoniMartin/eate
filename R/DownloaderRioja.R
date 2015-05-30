#' @include Downloader.R
DownloaderRioja<-R6Class("SingletonContainer",inherit=Singleton,portable=FALSE,
                         public=list(
                           initialize=function(...)
                           {
                             Class<<-R6Class("DownloaderRioja",portable=F,
                                             inherit=Downloader,
                                             public=list(
                                               getHour=function(pStation,pDate)
                                               {
                                                 codEst=substr(pStation$getCode(),4,5);
                                                 codOrg=substr(pStation$getCode(),3,3);
                                                 #Ver si esto se puede paralelizar
                                                 urlSpeed<-paste("http://ias1.larioja.org/estaciones/estaciones/mapa/informes/resultados.jsp?codOrg=",codOrg,"&codigo=",codEst,"&codigoP=7&Seleccion=D&Ano=",pDate$getYear(),"&Mes=",pDate$getMonth(),"&DiaD=",pDate$getDay(),"&DiaH=",pDate$getDay(),"&FechaD=",pDate$printDateNoHourNonStandard(),"&FechaH=",pDate$printDateNoHourNonStandard(),"&HoraD=",pDate$getHour(),":00:00","&HoraH=",pDate$getHour(),":59:00",sep="")
                                                 urlDirection<-paste("http://ias1.larioja.org/estaciones/estaciones/mapa/informes/resultados.jsp?codOrg=",codOrg,"&codigo=",codEst,"&codigoP=8&Seleccion=D&Ano=",pDate$getYear(),"&Mes=",pDate$getMonth(),"&DiaD=",pDate$getDay(),"&DiaH=",pDate$getDay(),"&FechaD=",pDate$printDateNoHourNonStandard(),"&FechaH=",pDate$printDateNoHourNonStandard(),"&HoraD=",pDate$getHour(),":00:00","&HoraH=",pDate$getHour(),":59:00",sep="")
                                                 urlTemperature<-paste("http://ias1.larioja.org/estaciones/estaciones/mapa/informes/resultados.jsp?codOrg=",codOrg,"&codigo=",codEst,"&codigoP=6&Seleccion=D&Ano=",pDate$getYear(),"&Mes=",pDate$getMonth(),"&DiaD=",pDate$getDay(),"&DiaH=",pDate$getDay(),"&FechaD=",pDate$printDateNoHourNonStandard(),"&FechaH=",pDate$printDateNoHourNonStandard(),"&HoraD=",pDate$getHour(),":00:00","&HoraH=",pDate$getHour(),":59:00",sep="")
                                                 
                                                 valuesSpeed <- readHTMLTable(htmlParse(urlSpeed), header=F);
                                                 valuesDirection<- readHTMLTable(htmlParse(urlDirection), header=F);
                                                 valuesTemperature <- readHTMLTable(htmlParse(urlTemperature), header=F);
                                                 
                                                 readVector=list();
                                                 if(length(valuesSpeed)>0)
                                                 {
                                                   tryCatch({
                                                     for(column in seq(from=3,to=nrow(valuesSpeed[[3]]),by=2))
                                                     {
                                                       date=Date$new(pDate$getYear(),pDate$getMonth(),pDate$getDay(),pDate$getHour(),15*((column-3)/2));
                                                       speed=as.double(gsub(",",".",as.character(valuesSpeed[[3]][column,7])));
                                                       direction=as.double(gsub(",",".",as.character(valuesDirection[[3]][column,5])));
                                                       temperature=as.double(gsub(",",".",as.character(valuesTemperature[[3]][column,5])));
                                                       
                                                       newRead<-Read$new(date,speed,direction,temperature);
                                                       readVector=c(readVector,newRead);
                                                     }
                                                     return(super$commitOrError(pStation,readVector))},
                                                     error=function(e){
                                                       print(e);
                                                     })
                                                 }
                                               }
                                             )
                             )
                             super$initialize();
                           }
                         )
)$new();