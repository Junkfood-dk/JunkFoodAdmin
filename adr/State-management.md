## Approach to state management

The following ADR serves as a clarification as to the decision we have made in regards to state management in our application.

### Why use Riverpod?
Initially, we started out using the Provider package for state management. However, upon revising our code base, and after refactoring much of our code, we instead decided to use Riverpod going forward. There are several reasons for this:

- Riverpod can be seen as a natural extension of the Provider package. Riverpod was developed by the same author who developed Provider, and thus builds upon the concepts introduced in the Provider package, while providing additional features. Moreover, the author recommends that a Flutter application prefers Riverpod over Provider going forward. 
- Riverpod allows for easier testing. As testing proved a large hurdle for us in the beginning stages of the project, the fact that Riverpod would allow us to more easily test our code was a major upside to the framework.
- Riverpod offers built-in support for things like dependency injection, which helps with separation of concerns in our code base, thus making our code cleaner and more maintainable.
<!---
### Why use provider?

The decision to use provider over Stateful widgets or another approach, is based upon the facts that:

- It is a recomended and well supported approach.
- It simplifies code by centralizing state logic.
- It allows for good seperation of concerns and high reusability.

These attributes makes for a great and scalable state management system, that subjectivly speaking is easy to use. -->
### Implementation

<!---The current implementation consits of two models, [DishModel](../lib/model/dish_model.dart) and [DishOfTheDayModel](../lib/model/dish_of_the_day_model.dart). The DishModel is not in relation to provider, but acts as the applications implementation of the dish model. It has a set of helper functions, that respectively parses from and to JSON objects, postable to the DB.
The DishOfTheDayModel acts as an example of a ChangeNotifier, providing the applicaiton with some functions for interacting with the dish of the day. It can post a new dish of the day, or check whether of not there already is one. The smart thing here is, that with the function `notifyListeners()` we can update all Consumers (subscribers) listening on the DishOfTheDayModel, that a change has been made, and while having full control over when this is done. Further we can place these Consumers as low as needed in the widget tree, limiting implications of the rebuild.-->

### Internal state handeling
<!--
When working with forms or other widgets that need some way of tracking their own internal state, provider is also helpful. Take [PostDishPage](../lib/pages/post_dish_page.dart) as an example. Here we have a ChangeNotifier class, that much like a StateFul widget, stores infromation about the state, and updates the UI accordingly. The pros with the provider approach having less boilerplate code. -->

### Choices made in regards to DishOfTheDayModel
<!--
Looking at [DishOfTheDayModel](../lib/model/dish_of_the_day_model.dart) there are some design choices that may need some clarification.
The reason only `fetchDishOfTheDay()` notifies listeners, is as to keep one single source of truth. When we post a new dish, it is the database that should hold information about the dish of the day, not the program itself. Say the DB lost the request, well then the program might wrongfully have updated internal dish of the day, without relfecting this amoung all subscribers. Therefore we must get the dish of the day directly from the db, and only then update the internal state.
-->