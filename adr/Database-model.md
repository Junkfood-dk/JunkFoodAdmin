## Initial Database Model

We have chosen an initial database model based on our interviews with the chef and business administrator of Junkfood.

### Dishes
A table consisting of the title, image, and description of the dish.

### DishType
We have chosen to create a table called DishType to differentiate between main course, alternative, and desserts, making it easier to present the dishes in the correct order. Therefore, each dish is associated with a dish type.

### Category
Junkfood wishes to collect data on their dishes and user preferences. We add this table to collect data for future use. This way, a dish does not need to be rated directly, but its category can be. This is because it may not be the same instance of the dish that is used multiple times, which could corrupt the data.

### Allergens
A list of allergens.

### DishSchedule
Here, each dish is stored by its ID together with a serving date. This allows us to query the table for all dishes for the current day, thus creating a menu if more dishes are added for the same day.

### ServingSpots
A list of serving spots and their specified serving days. This list is static on the app for now, but Junkfood can add to it if they find new serving spots. In the future, this could be linked to the Dish Schedule so that the app's list is dynamic, showing only the spots where the food is served on the current day.


![Intial-IR-diagramv4 drawio](https://github.com/Junkfood-dk/JunkFoodAdmin/assets/118807770/513a771f-8855-4af1-89f6-84958172a0aa)




