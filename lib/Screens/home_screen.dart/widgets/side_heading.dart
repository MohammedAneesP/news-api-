import 'package:flutter/material.dart';

class SideHeading extends StatelessWidget {
  final String textOne;
  final String textTwo;
  final VoidCallback anOnPressed;
  const SideHeading({
    required this.textOne,
    required this.textTwo,
    required this.anOnPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            textOne,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          TextButton(
            onPressed: anOnPressed,
            child: Text(
              textTwo,
              style: const TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}
