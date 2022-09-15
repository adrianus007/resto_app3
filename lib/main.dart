import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restorant_app/data/model/restaurant.dart';
import 'package:restorant_app/provider/database_provider.dart';
import 'package:restorant_app/provider/preferences_provider.dart';
import 'package:restorant_app/provider/restorant_provider.dart';
import 'package:restorant_app/provider/scheduling_provider.dart';
import 'package:restorant_app/ui/restaurant_detail_page.dart';
import 'package:restorant_app/ui/home_page.dart';
import 'package:restorant_app/utils/backround_service.dart';
import 'package:restorant_app/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/api/api_service.dart';
import 'data/db/database_helper.dart';
import 'data/preferences/preferences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => RestaurantProvider(apiService: ApiService()),
          ),
          ChangeNotifierProvider(create: (_) => SchedulingProvider()),
          ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
          ),
        ],
        child:
            Consumer<PreferencesProvider>(builder: (context, provider, child) {
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
                    restaurant: ModalRoute.of(context)?.settings.arguments
                        as Restaurant,
                  ),
            },
            );}
        )
    );
  }
}
