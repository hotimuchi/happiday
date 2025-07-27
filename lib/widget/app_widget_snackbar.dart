import 'package:flutter/material.dart';

appWidgetSnackBar(BuildContext context, Color color, String label) =>
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(label), backgroundColor: color));
