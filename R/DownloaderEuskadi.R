#' @include Downloader.R
DownloaderEuskadi<-R6Class("SingletonContainer",inherit=Singleton,portable=FALSE,
                           public=list(
                             initialize=function(...)
                               {
                               Class<<-R6Class("DownloaderEuskadi",portable=F,
                                               inherit=Downloader,
                                               public=list(
                                                 getHour=function(pStation,pDate)
                                                 {
                                                   url<-paste("http://www.euskalmet.euskadi.net/s07-5853x/es/meteorologia/lectur_fr.apl?e=5&anyo=",pDate$getYear(),"&mes=",pDate$getMonth(),"&dia=",pDate$getDay(),"&hora=",sprintf("%.2d",pDate$getHour()),":00","%20",sprintf("%.2d",pDate$getHour()),":59","&CodigoEstacion=",pStation$getCode(),"&pagina=1&R01HNoPortal=true",sep="");
                                                   values <- head(as.data.frame(readHTMLTable(htmlParse(getURL(url)), header=F)),-4);
                                                   readVector=list();
                                                   if(nrow(values)>0)
                                                   {
                                                     tryCatch({
                                                     for(column in 1:nrow(values))
                                                     {
                                                       date=Date$new(pDate$getYear(),pDate$getMonth(),pDate$getDay(),pDate$getHour(),10*column-10);
                                                       speed=as.numeric(sub(",", ".",values[2][column,]));
                                                       direction=as.numeric(sub(",",".",values[3][column,]));
                                                       temperature=as.numeric(sub(",", ".", values[7][column,]));
                                                       newRead<-Read$new(date,speed,direction,temperature);
                                                       readVector=c(readVector,newRead);
                                                     }
                                                     return(super$commitOrError(pStation,readVector))},
                                                     error=function(e){
                                                        
                                                     })
                                                   }
                                                 }
                                               )
                               )
                               super$initialize();
                             }
                             )
)$new();