Date<-R6Class("date",portable=F,
                 private=list(
                   year="numeric",
                   month="numeric",
                   day="numeric",
                   hour="numeric",
                   minutes="numeric")
                 ,public=list(
                   initialize=function(pYear,pMonth,pDay,pHour,pMinutes)
                   {
                     if(!missing(pYear)) private$year=pYear;
                     if(!missing(pMonth)) 
                       if(pMonth>0 && pMonth<13)
                       {
                         private$month=pMonth;
                       }else
                       {
                         stop("Invalid month");
                       }
                     if(!missing(pDay)) private$day=pDay;
                     if(!missing(pHour)) 
                       if(pHour>=0 && pHour<24)
                       {
                         private$hour=pHour;
                       }else
                       {
                         stop("Invalid hour");
                       }
                     if(!missing(pMinutes)) 
                       if(pMinutes>=0 && pMinutes<60)
                         {
                         private$minutes=pMinutes;
                       }else
                       {
                         stop("Invalid minutes");
                       }
                   },
                   printDate=function()
                   {
                     paste(private$year,"-",sprintf("%.2d",private$month),"-",sprintf("%.2d",private$day)," ",sprintf("%.2d",private$hour),":",sprintf("%.2d",private$minutes),sep="");
                   },
                   printHour=function()
                   {
                     paste(private$hour,":",private$minutes,sep="");
                   },
                   printDateNoMinutes=function()
                   {
                     paste(private$year,"-",sprintf("%.2d",private$month),"-",sprintf("%.2d",private$day)," ",sprintf("%.2d",private$hour),":00",sep="");
                   },
                   printDateNoHour=function()
                   {
                     paste(private$year,"-",sprintf("%.2d",private$month),"-",sprintf("%.2d",private$day),sep="");
                   },
                   printDateNoHourNonStandard=function()
                   {
                     paste(sprintf("%.2d",private$day),sprintf("%.2d",private$month),sprintf("%.2d",private$year),sep="-");
                   },
                   getYear=function()
                     {
                     return(private$year);
                   },
                   getMonth=function()
                     {
                     return(private$month);
                   },
                   getDay=function()
                     {
                     return(private$day);
                   },
                   getHour=function()
                   {
                     return(private$hour);
                   },
                   getMinutes=function()
                     {
                     return(private$minutes);
                   })
)
