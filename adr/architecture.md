## Description of the architecture

This document is meant as a guide for current and future developers, as to understand the architecture and structure of the project.

### Reason to change

The current architecture was implemented after an initial period of just building in relative blindness, without regard for a larger coherence. This initially lead to multiple issues, including lack of readability, lack of a common naming convention, no larger project structure (besides the one flutter maintains) and lastly major issues testing. A good rule of thumb usually says that if the code *does not test itself* or is difficult to test, it is not good code. After longer struggles with testing, it became clear that we needed to restructure and rethink our approach to the general strucutre of the project, and on this learning path also changing the approach to state management.

### Architectural overview

![Architectural diagram](/adr/images/architectural-diagram.png)

The overall architecture is based on a layered approach with four layers, each with their own responsibilities. Currently our implementation omits the fourth layer, the application layer, since we have not yet seen the need for it. This approach of only implementing the parts that make sense, works to make an architecture that works for our project and not add boilerplate code and classes.
The three other layers are:

- **Data layer:** Fetches, loads and persists data
- **UI layer:** Displays the data and manipulates it
- **Domain layer:** Describes the domain of the program and the relation of the different enitites

In many frameworks it is good practice for communication between the layers to happen through interfaces, so as to make the code more modular. We have not directly adopted this approach instead opting for a more flutter-specific implementation using riverpod. Riverpod is used to expose and communicate between layers. The reason for choosing this approach is because Riverpod offers a lot of functionality and as described in their [documentation relating to providers](https://riverpod.dev/docs/concepts/providers):
"_Providers are a complete replacement for patterns like Singletons, Service Locators, Dependency Injection or InheritedWidgets_"
To read more about our use of provider, please see the adr on [state management](state-management.md).

#### Data layer

The data layer contains repositories that are the classes responsible for fetching and persisting data in for example a remote database. We have chosen to use interfaces (in flutter abstract interface) to implement these repositories, so as to make the application independent of the database implementation (and for easy testing). The repository implementations are then exposed using riverpod, and the same goes for the database client. This gives us a data layer that has good seperation of concerns as well as modularity.

#### Domain layer

Our domain layer holds the models used to represent our data in the application. These models are responsible for holding data, showing relations between models as well as options for encoding and decoding of JSON.

#### UI layer (Presentation layer)

The UI layer, also known as the Presentaiton layer, consists of three further divisions: Pages, Widgets and Controllers. 
As a rule of thumb, the difference between a page and a widget, is that a page is wrapped in a scaffold although technically they are the same as everything in flutter are widgets. To look at it from a more web-dev approach, widgets are like components from frameworks like React.
The controllers are a new addition to our structure, and holds a major role. It is somewhat different from MVC, and a controller can essentially be seen as "controlling a piece of state". We use Notifiers from riverpod to expose pieces of state as well as expose methods for interacting with them. This seperates business logic from display logic, clearing up the UI-classes aswell as making for better seperation of concerns. This also makes the code more testable, as the providers can be "mocked", and we can test the UI that way.