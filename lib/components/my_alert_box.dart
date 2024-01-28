import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintText;

  const MyAlertBox(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600]),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
      actions: [
        MaterialButton(
          color: Colors.black,
          onPressed: onSave,
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          color: Colors.black,
          onPressed: onCancel,
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
