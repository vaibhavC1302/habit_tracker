import 'package:habit_tracker/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDatabase {
  List todaysHabitList = [];
  Map<DateTime, int> heatMapDataset = {};

  // create initial default data
  void createDefaultData() {
    todaysHabitList = [
      ["Read", false],
      ["Gym", false]
    ];

    _myBox.put("START_DATE", todaysDateFormatted());
  }

  //load data if already exist
  void loadData() {
    //if its a new day get habit list from datebase
    if (_myBox.get(todaysDateFormatted()) == null) {
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
    }
    // if its not a new day then load todays habitlist
    else {
      todaysHabitList = _myBox.get(todaysDateFormatted());
    }
  }

  //update a database
  void updateDatabase() {
    _myBox.put(todaysDateFormatted(), todaysHabitList);
    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);
    calculateHabitPercentage();
    loadHeatmap();
    print(_myBox.get("CURRENT_HABIT_LIST"));
  }

  void calculateHabitPercentage() {
    int countCompleted = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][1] == true) {
        countCompleted++;
      }
    }
    String percent = todaysHabitList.isEmpty
        ? "0.0"
        : (countCompleted / todaysHabitList.length).toStringAsFixed(1);

    //key = PERCENTAGE_SUMMARYT_yyyymmdd
    //value = number between 0.0 and 1.0

    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatmap() {
    DateTime startdate = createDateTimeObject(_myBox.get("START_DATE"));

    //count the number of days to load

    int daysInBetween = DateTime.now().difference(startdate).inDays;

    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startdate.add(
          Duration(days: i),
        ),
      );

      double strength = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      int year = startdate.add(Duration(days: i)).year;

      int month = startdate.add(Duration(days: i)).month;

      int days = startdate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, days): (strength * 10).toInt(),
      };
      heatMapDataset.addEntries(percentForEachDay.entries);
    }
  }
}
