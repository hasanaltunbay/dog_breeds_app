import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final TextEditingController controller;
  final void Function(String)? onChanged;

  MyTextField(
      {super.key,
        required this.controller,
        required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
        maxLines: 5,
        minLines: 1,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search",
          border: InputBorder.none,
        ));
  }
}
