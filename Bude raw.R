library(ggmap)

# Bude road map
road <- get_map(location = "Bude", zoom = 14)
ggmap(road)

# Bude watercolor
watercolor <- get_map(location = "Bude", maptype = "watercolor", zoom = 14)
ggmap(watercolor)

# vacation spots
df <- data.frame(location = c("Summerleaze Beach", 
                              "Crooklets Beach","The Brendon Arms","Edgcumbe Hotel"), 
                 values = c(30, 30), 
                 stringsAsFactors = FALSE)
locs_geo <- geocode(df$location)
df <- cbind(df, locs_geo)

ggmap(road) +
  geom_point(data = df, 
             aes(x = lon, y = lat, size = values))
  
ggmap(watercolor) +
  geom_point(data = df, 
             aes(x = lon, y = lat, size = values)) +
  geom_text(data = df,
            aes(x = lon, y = lat, label = location),
            color = 'blue')

# route from cricket club to pub
from <- "Bude North Cornwall Cricket Club"
to <- "Crooklets Inn"
route_df <- route(from, to, structure = "route")
df_pub <- data.frame(location = c("Crooklets Inn",
                                  "Bude North Cornwall Cricket Club"),
                     values = c(15, 15),
                     stringsAsFactors = FALSE)
locs_geo <- geocode(df_pub$location)
df_pub <- cbind(df_pub, locs_geo)

map <- get_map(location = "Crooklets Beach", zoom = 16)
ggmap(map) +
  geom_point(data = df_pub, 
             aes(x = lon, y = lat, size = values)) +
  geom_text(data = df_pub,
            aes(x = lon, y = lat, label = location),
            color = 'blue') +
  geom_path(aes(x = lon, y = lat),
            colour = "red",
            size = 1.5, 
            data = route_df,
            lineend = "round")

##To get the pictures of your favourite locations##
##Install package magick
##load the library(magick)
library(magick)
EdgcumbeHotelimge <- image_scale(image_read('https://www.theweddingsecret.co.uk/img/uploads/businessgallery/57628dbac3e09_Ceremony_2.jpg',"x175"))
print(CrookletsBeachimge)
BrendonArmsimge <- image_scale(image_read('https://s-ec.bstatic.com/images/hotel/max1280x900/282/28226592.jpg',"x175"))
print(BrendonArmsimge)

