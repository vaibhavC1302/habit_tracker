import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  const HabitTile(
      {super.key,
      required this.habitName,
      required this.habitCompleted,
      required this.onChanged,
      required this.settingsTapped,
      required this.deleteTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            //setting option
            SlidableAction(
              onPressed: settingsTapped,
              icon: Icons.edit,
              backgroundColor: Colors.grey[800]!,
              borderRadius: BorderRadius.circular(12),
            ),
            //delete option
            SlidableAction(
              onPressed: deleteTapped,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Checkbox(
                value: habitCompleted,
                onChanged: onChanged,
              ),
              Text(habitName)
            ],
          ),
        ),
      ),
    );
  }
}
