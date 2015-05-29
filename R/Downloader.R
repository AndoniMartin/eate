Downloader<-R6Class("Downloader",portable=F,
                    public=list(
                      commitOrError=function(pStation,pReadList)
                      {
                        print(pReadList);
                        tryCatch(DatabaseManager$getInstance()$saveReadList(pStation,pReadList)
                                 ,error=function(error)
                                 {
                                   print("An error was detected when trying to save reads");
                                   print(error);
                                   return(error);
                                 }
                                 ,finally=
                                 {
                                   #Falta discriminar cuando hay error o algo, la lepra es algo
                                   output=HourFactory$getInstance()$produceHour(pReadList);
                                   tryCatch(DatabaseManager$getInstance()$saveHour(pStation,output),
                                            error=function(error)
                                            {
                                              print("An error was detected when trying to save the hour");
                                              print(error);
                                              return(error);
                                            }
                                            )
                                   return(output);
                                 }
                        )
                      }
                    )
);
                                 