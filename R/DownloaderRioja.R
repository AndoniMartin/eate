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
                                                   #Meter código de estación y código de organización
                                                   url<-paste("http://ias1.larioja.org/estaciones/estaciones/mapa/informes/resultados.jsp?codOrg=",codOrg,"&codigo=",codEst,"&codigoP=6&Seleccion=D&Ano=",pDate$getYear(),"&Mes=",pDate$getMonth(),"&DiaD=",pDate$getDay(),"&DiaH=",pDate$getDay(),"&FechaD=",pDate$printDateNoHourNonStandard(),"&FechaH=",pDate$printDateNoHourNonStandard(),"&HoraD=",pDate$getHour(),":00:00","&HoraH=",pDate$getHour(),":59:00",sep="")
                                                   values <- readHTMLTable(htmlParse(url), header=F);
                                                   
                                                   }
                                                 )
                                               )
                               super$initialize();
                             }
                           )
                           )$new();