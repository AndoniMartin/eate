#http://cran.r-project.org/web/packages/R6/vignettes/Performance.html#memory-footprint

#Singleton pattern
Singleton<-R6Class("Singleton",
                   portable=FALSE,
                   private=list(
                     Class="ANY",
                     instance="ANY"
                     ),
                   public=list(
                     initialize=function(...)
                     {
                     private$instance<<- NULL
                   },
                   getInstance=function(...)
                     {
                     if(is.null(private$instance))
                       private$instance<<-Class$new(...);  
                     return(private$instance);
                      
                   }))

#makeSingleton<-function(class)
#{
#  return
#}
## Singleton pattern
#Singleton <- setRefClass("Singleton",
 #                        fields=list(
 #                          Class="ANY",
  #                         instance="ANY"
   #                      ),
    #                     methods=list(
     #                      initialize=function(...) {
      #                       "Override this by defining Class"
       #                      instance <<- NULL
        #                     callSuper(...)
         #                  },
          #                 getInstance=function(...) {
           #                  "Get a unique instance of the class defined in the subclasses initialize method"
            #                 if(is.null(instance))
             #                  instance <<- Class$new(...)
              #               instance
               #              
                #           }
                 #        ))