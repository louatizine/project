import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.label, required this.ontap, required TextStyle style})
      : super(key: key);
  final String label;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 45,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blueAccent),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}