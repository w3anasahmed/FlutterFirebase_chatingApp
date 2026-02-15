import 'package:flutter/material.dart';

class UserListtile extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const UserListtile({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),

        child: Row(
          children: [Icon(Icons.person), SizedBox(width: 15), Text(text)],
        ),
      ),
    );
  }
}
