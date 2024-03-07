import 'package:chefapp/main.dart';
import 'package:chefapp/model/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class PostDishPage extends StatelessWidget {
  TextStyle labelText =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostDishPageState(),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Chef"),
          ),
          body: Center(
              child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.6,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Consumer<PostDishPageState>(
                      builder: (context, state, _) => TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Name"),
                            onChanged: (value) => state.setTitle(value),
                          )),
                  Consumer<PostDishPageState>(
                      builder: (context, state, _) => TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Description"),
                            onChanged: (value) => state.setDescription(value),
                          )),
                  Consumer<PostDishPageState>(
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
                  Consumer<PostDishPageState>(
                      builder: (context, state, _) => TextFormField(
                            validator: (value) {
                              if (!isValidUrl(value!)) {
                                return "Please enter a valid URL";
                              } else {
                                return null;
                              }
                            },
                            decoration:
                                const InputDecoration(labelText: "ImageURL"),
                            onChanged: (value) {
                              if (isValidUrl(value)) {
                                state.setImageUrl(value);
                              }
                            },
                          )),
                  Consumer<PostDishPageState>(
                      builder: (context, state, _) => TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              state.submitDish();
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text("Submit")))
                ],
              ),
            ),
          ))),
    );
  }

  bool isValidUrl(String protenitalUri) {
    Uri? uri = Uri.tryParse(protenitalUri);
    return uri != null && uri.isAbsolute;
  }
}

class PostDishPageState extends ChangeNotifier {
  String title = "";
  String description = "";
  int calories = 0;
  String imageUrl = "";

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

  void setImageUrl(String newValue) {
    imageUrl = newValue;
    notifyListeners();
  }

  Future<void> submitDish() async {
    DishModel newDish = DishModel(
        title: title,
        description: description,
        calories: calories,
        imageUrl: imageUrl);
    var row = await supabase.from("Dishes").insert(newDish).select("id");
    var id = row[0]['id'];
    await supabase.from("Dish_Schedule").insert(
        {'id': id, 'date': DateTime.now().toIso8601String()}).select("id");
  }
}
