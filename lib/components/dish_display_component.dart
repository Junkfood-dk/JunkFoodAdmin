import 'package:chefapp/model/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DishDisplayComponent extends StatelessWidget {
  DishModel dish;
  DishDisplayComponent({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Row(
          children: [
            (Column(
              children: [
                Text(
                  dish.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(dish.description),
                Text("Calories: ${dish.calories}"),
              ],
            )),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.4,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Image.network(dish.imageUrl)),
            )
          ],
        ),
      ),
    );
  }
}
