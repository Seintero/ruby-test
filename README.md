# README

Simple admin panel for editing. Display events with filtering and search with pagination. 
The ability to look at the map or add to the calendar when viewing events in detail.
Demo url: https://stormy-eyrie-09818.herokuapp.com/ 
 
 
### Some requirements
ruby 
>'2.7.1'

rails 
>'~> 6.0.3'

ImageMagick or GraphicsMagick command-line tool has to be installed. You can check if you have it installed by running

>convert -version


### Main commands
Load migrations 
> rails db:migrate

Upload initial data
> rails db:seed

Test command 
> rails test

Sending notifications to subscribers about events tomorrow
> rails subscribers:notify