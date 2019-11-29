library(rsconnect) 

rsconnect::setAccountInfo(name='manita',
                          token='85978586FA9E82BDF3FD6F5C6937EE61',
                          secret='brLnvM87xu9lQwPPAAg0tAj51Gd28QB6d8qVEvtv')

deployApp(appName = "final")

rsconnect::deployApp('C:/Users/vitor/OneDrive - NOVAIMS/DV/final') 