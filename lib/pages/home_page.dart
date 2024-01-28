import 'package:flutter/material.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/monthly_summary.dart';
import 'package:habit_tracker/components/my_fab.dart';
import 'package:habit_tracker/components/my_alert_box.dart';
import 'package:habit_tracker/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _mybox = Hive.box("Habit_Database");

  @override
  void initState() {
    //if there is no CURRENT_HABIT_LIST, then it is the first time opening the app
    //then create default data
    if (_mybox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } // there already existe data and it is not the first time opening the app
    else {
      db.loadData();
    }

    //update the database
    db.updateDatabase();

    super.initState();
  }

  //checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
    db.updateDatabase();
  }

  //create new habbit
  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertBox(
            hintText: "Enter habit name",
            controller: _newHabitNameController,
            onSave: saveNewHabit,
            onCancel: cancelDialogBox,
          );
        });
  }

  //save new habtit
  void saveNewHabit() {
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
    });

    _newHabitNameController.clear();

    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // cancel new habit
  void cancelDialogBox() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  //open habit settings to edit
  void openHabitSettings(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertBox(
              hintText: db.todaysHabitList[index][0],
              controller: _newHabitNameController,
              onSave: () => saveExistingHabit(index),
              onCancel: cancelDialogBox);
        });
  }

  //save existing habit with new name
  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  // delete habit tapped

  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: MyFloatingActionButton(
          onPressed: createNewHabit,
        ),
        backgroundColor: Colors.grey[300],
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            //monthly summary heatmap
            MonthlySummary(
                dataset: db.heatMapDataset,
                startDate: _mybox.get("START_DATE")),

            // habit list tiles
            ListView.builder(
              shrinkWrap: true,
              itemCount: db.todaysHabitList.length,
              itemBuilder: (context, index) {
                return HabitTile(
                  habitName: db.todaysHabitList[index][0],
                  habitCompleted: db.todaysHabitList[index][1],
                  onChanged: (value) => checkBoxTapped(value, index),
                  settingsTapped: (context) => openHabitSettings(index),
                  deleteTapped: (context) => deleteHabit(index),
                );
              },
            ),
          ],
        ));
  }
}
