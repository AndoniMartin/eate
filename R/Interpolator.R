Interpolator<-R6Class("SingletonContainer",
                      portable=FALSE,
                      inherit=Singleton,
                      public=list(
                        initialize=function(...)
                        {
                          Class<<-R6Class("Interpolator",portable=F,
                                          public=list(
                                            interpolate=function(pHourDump)
                                              {
                                              #Make sumthin'
                                            })
                          )
                          super$initialize();
                        }))$new();