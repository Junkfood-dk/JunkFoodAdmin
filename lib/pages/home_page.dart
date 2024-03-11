import 'package:chefapp/components/dish_display_component.dart';
import 'package:chefapp/model/dish_of_the_day_model.dart';
import 'package:chefapp/pages/post_dish_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chef"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Consumer<DishOfTheDayModel>(builder: (context, state, _) {
          return FutureBuilder(
              future: state.hasDishOfTheDay,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  if (!snapshot.data!) {
                    return TextButton(
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PostDishPage(),
                      )),
                      child: const Text("Post dish"),
                    );
                  } else {
                    return Column(
                      children: [
                        Center(
                            child:
                                DishDisplayComponent(dish: state.dishOfTheDay))
                      ],
                    );
                  }
                }
              });
        }),
      ),
    );
  }
}
