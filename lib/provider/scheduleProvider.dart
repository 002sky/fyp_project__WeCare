import 'package:flutter/cupertino.dart';
import 'package:fyp_project_testing/modal/schedule.dart';
import 'package:fyp_project_testing/provider/scheduleUtility.dart';

class ScheduleProvider extends ChangeNotifier {
  List<Schedule>? _schedule = [];

  bool _isloading = false;

  List<Schedule> get schedule {
    return [...?_schedule];
  }

  getScheduleData(String id) async {
    List<Schedule>? loadedSchdule = [];

    _isloading = true;

    loadedSchdule = (await fetchScheduleData(id));

    _isloading = false;

    _schedule = loadedSchdule;

    notifyListeners();
  }

  setScheduleData(String data) async {
    bool success = false;

    _isloading = true;

    success = addScheduleData(data) as bool;

    _isloading = false;

    notifyListeners();
  }
}
