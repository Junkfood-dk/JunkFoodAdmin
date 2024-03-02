## Initial database model

We have thoosen an intial database model base on our interview of the chef and business administrator of Junkfood.

### Dishes
A table consisting of the title, the image and the description of the dish.

### Dishtype
We have chosen to create a table called DishType as a way of differentiating between main, alternative and desserts, to make it easyer to present the dishes in the right order.
So every dish gets a reference to a dishtype.

### Category
Junkffod wants a way to gather data of their dishes and how the users likes them. Therefor we add this table to colect data in the future.
This way a dish does not have to be directly rated, but its category can. That is because it is not necessary the same instance of the dish that is used multible times, and therefor the data could be curupted.

### Alergens
Is a list of alergens.

### DishSchedule
Here a dish is story by its id together with a serving date. This way you can query the table for all dishes for the current day, thereby creating a menu, if more dishes is add to the same day.

### ServingSpots
A list of servingspots and a specifiction on which day they serve Junkfoods food, which of right now just serves a staic list on the app, which junkfood can add to, if a new serving spot is found. 
In the furture this could be related to the DishSchedule, so that the list on the app is dynamic, only showing the spots where the food is served on the current day.

![Intial-IR-diagramv4 drawio](https://github.com/Junkfood-dk/JunkFoodAdmin/assets/118807770/513a771f-8855-4af1-89f6-84958172a0aa)




