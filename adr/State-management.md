## Approach to state management

The following ADR serves as a clarification as to the decision we have made in regards to state management in our application.

### Why use Riverpod?
Initially, we started out using the Provider package for state management. However, upon revising our code base, and after refactoring much of our code, we instead decided to use Riverpod going forward. There are several reasons for this:

- Riverpod can be seen as a natural extension of the Provider package. Riverpod was developed by the same author who developed Provider, and thus builds upon the concepts introduced in the Provider package, while providing additional features. Moreover, the author recommends that a Flutter application prefers Riverpod over Provider going forward. 
- Riverpod allows for easier testing. As testing proved a large hurdle for us in the beginning stages of the project, the fact that Riverpod would allow us to more easily test our code was a major upside to the framework.
- Riverpod offers built-in support for things like dependency injection and singleton pattern, which helps with separation of concerns in our code base, thus making our code cleaner and more maintainable.

### Implementation


We will motivate the implementation of riverpod through the use of a specific example, in this case the functionality for adding allergenes to a dish. However, the same logic applies to any other functionality that makes use of state management, and thus this simple example should serve as a proper introduction to our thought process. Furthermore, this also gives a short introduction into the redesign of our application after we have done a big refactoring of our code base (for more details, see the specific ADR for refactoring).

Firstly, we have [allergen_model](lib\Domain\model\allergen_model.dart). This class is not directly related to riverpod, but instead has a couple of very useful helper functions, that respectively parses from and to JSON objects, which are then portable to the DB.Next, we have [allergenes_repository](lib\Data\allergenes_repository.dart), which includes a function called allergenesRepository that is prefaced by a riverpod annotation. 

Now, in the [allergenes_controller](lib\UI\Controllers\allergenes_controller.dart) class is where the real magic happens. First of all, we have the *build* method, which tells riverpod to create an initial state of the allergenes repository. It does this by calling the *fetchAllergenes*, which gets all the allergenes currently present in the database. Obviously, this is useful in its own right, but what we really want to do is to allow the user of the application to dynamically add new allergenes. For this, we are using the *postNewAllergen* method. With this method, we are telling riverpod to update the state (with the newly specified allergen), and to render it, hence updating the UI. And, as mentioned earlier, since we are using riverpod, we are guaranteed to communicate with the same instance of the AllergenesRepository object, and thus benefiting us in a number of ways, such as limiting memory usage and preventing potential race conditions. That's not to say that we wouldn't have been able to work around this without riverpod, nor is it even the primary reason we're using the framework to begin with, but it certainly makes our lifes easier!
<!--The current implementation consits of two models, [DishModel](../lib/model/dish_model.dart) and [DishOfTheDayModel](../lib/model/dish_of_the_day_model.dart). The DishModel is not in relation to provider, but acts as the applications implementation of the dish model. It has a set of helper functions, that respectively parses from and to JSON objects, postable to the DB.
The DishOfTheDayModel acts as an example of a ChangeNotifier, providing the applicaiton with some functions for interacting with the dish of the day. It can post a new dish of the day, or check whether of not there already is one. The smart thing here is, that with the function `notifyListeners()` we can update all Consumers (subscribers) listening on the DishOfTheDayModel, that a change has been made, and while having full control over when this is done. Further we can place these Consumers as low as needed in the widget tree, limiting implications of the rebuild.-->

### Internal state handeling
<!--
When working with forms or other widgets that need some way of tracking their own internal state, provider is also helpful. Take [PostDishPage](../lib/pages/post_dish_page.dart) as an example. Here we have a ChangeNotifier class, that much like a StateFul widget, stores infromation about the state, and updates the UI accordingly. The pros with the provider approach having less boilerplate code. -->