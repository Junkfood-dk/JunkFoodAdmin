import 'package:chefapp/main.dart';
import 'package:chefapp/model/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                Consumer<HomePageState>(
                    builder: (context, state, _) => TextFormField(
                          decoration: const InputDecoration(labelText: "Name"),
                          onChanged: (value) => state.setTitle(value),
                        )),
                const SizedBox(
                  height: 20,
                ),
                Consumer<HomePageState>(
                    builder: (context, state, _) => TextFormField(
                          decoration:
                              const InputDecoration(labelText: "Description"),
                          onChanged: (value) => state.setDescription(value),
                        )),
                Consumer<HomePageState>(
                    builder: (context, state, _) => TextFormField(
                          decoration:
                              const InputDecoration(labelText: "Calories"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) =>
                              state.setCalories(int.parse(value)),
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
  int calories = 0;

  void setTitle(String newValue) {
    title = newValue;
    notifyListeners();
  }

  void setDescription(String newValue) {
    description = newValue;
    notifyListeners();
  }

  void setCalories(int newValue) {
    if (newValue >= 0) {
      calories = newValue;
      notifyListeners();
    } else {
      throw Exception("Calory count can't be negative");
    }
  }

  Future<void> submitDish() async {
    DishModel newDish =
        DishModel(title: title, description: description, calories: calories);
    await supabase.from("Dishes").insert(newDish);
  }
}
