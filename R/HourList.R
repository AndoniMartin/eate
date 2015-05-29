library("hash")


#TODO:Validación de tipos
HourList<-R6Class("HourList",portable=F,
                  public=list(
                    initialize=function()
                    {
                      private$hoursHash=hash();
                    },
                    addHour=function(pHour)
                      {
                      private$hoursHash[[pHour$getDate()$printDateNoMinutes()]]=pHour;
                    },
                    getHour=function(pDate)
                      {
                      return(private$hoursHash[[pDate$printDateNoMinutes()]]);
                    }),
                  private=list(
                    hoursHash="HASH"
                    )
                  );