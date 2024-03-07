import 'package:chefapp/pages/post_dish_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chefapp/main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageState(),
      child: (Scaffold(
        appBar: AppBar(
          title: const Text("Chef"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Consumer<HomePageState>(builder: (context, state, _) {
            return FutureBuilder(
                future: state.hasDishOfTheDay,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
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
                      return const Text("It already exists");
                    }
                  }
                });
          }),
        ),
      )),
    );
  }
}

class HomePageState extends ChangeNotifier {
  Future<bool> get hasDishOfTheDay async {
    var dishOfTheDay = await supabase
        .from("Dish_Schedule")
        .select()
        .filter("date", "eq", DateTime.now().toIso8601String());
    return dishOfTheDay.isNotEmpty;
  }
}
