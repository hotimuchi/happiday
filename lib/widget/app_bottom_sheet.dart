import 'package:flutter/material.dart';

appBottomSheet(BuildContext context, Widget builder, {double size = 0.9}) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: size,
            builder: (context, scrollController) => builder,
          ),
    );
