#Hour factory class
HourFactory<-R6Class("SingletonContainer",portable=FALSE,inherit=Singleton,
                     public=list(
                       initialize=function(...)
                       {
                         Class<<-R6Class("HourFactory",portable=FALSE,
                                         public=list(
                                           produceHour=function(pReadList)
                                           {
                                             accumulator=complex(0,0);
                                             miniumSpeed=.Machine$integer.max;
                                             maxiumSpeed=-.Machine$integer.max;
                                             miniumTemperature=.Machine$integer.max;
                                             maxiumTemperature=-.Machine$integer.max;
                                             meanTemperature=0;
                                             
                                             for(i in 1:length(pReadList))
                                             {
                                               actual=pReadList[[i]];
                                               accumulator=accumulator+actual$toComplex();
                                               meanTemperature=meanTemperature+actual$getTemperature();
                                              if(actual$getSpeed()<miniumSpeed)
                                              {
                                                miniumSpeed=actual$getSpeed();
                                              }
                                              if(actual$getSpeed()>maxiumSpeed)
                                              {
                                                maxiumSpeed=actual$getSpeed();
                                              }
                                              if(actual$getTemperature()<miniumTemperature)
                                              {
                                                miniumTemperature=actual$getTemperature();
                                              }
                                              if(actual$getTemperature()>maxiumTemperature)
                                              {
                                                maxiumTemperature=actual$getTemperature();
                                              }
                                             }
                                             meanSpeed=Mod(accumulator)/length(pReadList);
                                             meanDirection=Arg(accumulator)*180/pi;
                                             
                                             #TODO: Comprobar esto.
                                             if(meanDirection<0)
                                             {
                                               meanDirection=meanDirection+360;
                                            }
                                             meanTemperature=meanTemperature/length(pReadList);
                                             date=pReadList[[1]]$getDate();
                                             date=Date$new(date$getYear(),date$getMonth(),date$getDay(),date$getHour(),0);
                                             
                                             return(
                                               Hour$new(meanSpeed,maxiumSpeed,miniumSpeed,meanTemperature,maxiumTemperature,miniumTemperature,meanDirection,date)
                                               );
                                           }
                                           )
                                         )
                         super$initialize(...);
                       }))$new();