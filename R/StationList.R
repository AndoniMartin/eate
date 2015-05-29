StationList<-R6Class("SingletonContainer",
                     portable=FALSE,
                     inherit=Singleton,
                     public=list(
                       initialize=function(...)
                       {
                         Class<<-R6Class("StationList",portable=F,
                                         private=list(
                                           mList=list(),
                                           length=0),
                                         public=list(
                                           initialize=function()
                                           {
                                             private$mList=DatabaseManager$getInstance()$getStationList();
                                             private$length=length(private$mList)
                                             #Esto también hay que afinarlo.
                                             doParallel::registerDoParallel(cores=length(private$mList))
                                           },
                                           getList=function()
                                           {
                                             return(private$mList);
                                           },
                                           dumpHourList=function(pDate)
                                           {
                                             #TODO: Dump hours standard formated.
                                             standardHourList<-foreach(i=1:private$length,.errorhandling=c("remove")) %dopar%
                                              {
                                                station=private$mList[[i]];
                                                hour=station$getHour(pDate);
                                                if(!is.null(hour))
                                                {
                                                  StandardHour$new(station,hour); 
                                                }
                                              }
                                              return(standardHourList[! sapply(standardHourList,is.null)]);
                                                                                         }))
                                              
                                              super$initialize(...);
                                                                     }
                                                                   ))$new();