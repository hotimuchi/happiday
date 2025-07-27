import 'package:flutter/material.dart';

class AppWidgetButton extends StatelessWidget {
  final double? paddingHorizontal;
  final double? paddingVertical;
  final String label;
  final VoidCallback? callback;
  const AppWidgetButton({
    super.key,
    this.paddingHorizontal,
    this.paddingVertical,
    required this.label,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal ?? 0,
          vertical: paddingVertical ?? 0,
        ),
      ),
      child: Text(label),
    );
  }
}
