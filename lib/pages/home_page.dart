import 'package:chefapp/main.dart';
import 'package:chefapp/model/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  TextStyle labelText =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageState(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Chef"),
            automaticallyImplyLeading: false,
          ),
          body: Center(
              child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.6,
            child: Column(
              children: [
                Text(
                  "Dish Title",
                  style: labelText,
                ),
                Consumer<HomePageState>(
                    builder: (context, state, _) => TextFormField(
                          onChanged: (value) => state.setTitle(value),
                        )),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Description",
                  style: labelText,
                ),
                Consumer<HomePageState>(
                    builder: (context, state, _) => TextFormField(
                          onChanged: (value) => state.setDescription(value),
                        )),
                Consumer<HomePageState>(
                    builder: (context, state, _) => TextButton(
                        onPressed: () => state.submitDish(),
                        child: const Text("Submit")))
              ],
            ),
          ))),
    );
  }
}

class HomePageState extends ChangeNotifier {
  String title = "";
  String description = "";

  void setTitle(String newValue) {
    title = newValue;
    notifyListeners();
  }

  void setDescription(String newValue) {
    description = newValue;
    notifyListeners();
  }

  Future<void> submitDish() async {
    DishModel newDish = DishModel(title: title, description: description);
    await supabase.from("Dishes").insert(newDish);
  }
}
