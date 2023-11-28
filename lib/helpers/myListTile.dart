import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final IconData icon2;
  final void Function()? onTap;

  const MyListTile(
      {super.key,
      required this.icon,
      required this.text,
      required this.icon2,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.black,
        size: 27,
      ),
      title: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 22),
      ),
      trailing: Icon(
        icon2,
        color: Colors.grey,
        size: 27,
      ),
      onTap: onTap,
    );
  }
}
