import 'package:flutter/material.dart';

class AcceptButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AcceptButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          // side: const BorderSide(color: Colors.black),
        ),
        minimumSize: const Size(60, 35),
      ),
      child: const Text("Accept"),
    );
  }
}

class DeclineButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeclineButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red[400],
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          // side: const BorderSide(color: Colors.black),
        ),
        minimumSize: const Size(60, 35),
      ),
      child: const Text("Decline"),
    );
  }
}
