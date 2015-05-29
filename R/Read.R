Read<-R6Class("Read",portable=F,
        private=list(
          date="ProDate",
          speed="numeric",
          direction="numeric",
          temperature="numeric"
           ),
        public=list(
          initialize=function(pDate,pSpeed,pDirection,pTemperature)
          {
            if(!missing(pDate)) private$date=pDate;
            if(!missing(pSpeed)) private$speed=pSpeed;
            if(!missing(pDirection)) private$direction=pDirection;
            if(!missing(pTemperature)) private$temperature=pTemperature;
          },
          getSpeed=function()
          {
            return(private$speed);
          },
          getTemperature=function()
          {
            return(private$temperature);
          },
          getDate=function()
          {
            return(private$date);
          },
          getDirection=function()
          {
            return(private$direction);
          },
          toComplex=function()
          {
            argument=private$direction*pi/180;
            return(complex(modulus=private$speed,argument=argument));
          }
            ))