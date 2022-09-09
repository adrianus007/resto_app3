import 'package:flutter/material.dart';
import 'package:restorant_app/data/model/article.dart';
import 'package:restorant_app/ui/restaurant_detail_page.dart';
import 'package:restorant_app/ui/home_page.dart';
import 'package:restorant_app/ui/restaurant_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
        ),


      },
    );
  }
}
