import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:restorant_app/utils/date_time_helper.dart';
import 'package:flutter/material.dart';

import '../utils/backround_service.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Alarm Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Alarm Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
