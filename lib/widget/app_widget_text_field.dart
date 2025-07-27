import 'package:flutter/material.dart';

class AppWidgetTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool? readOnly;
  final void Function()? onTap;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final bool? autofocus;
  final void Function(String)? onChanged;

  const AppWidgetTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.readOnly,
    this.onTap,
    this.maxLines,
    this.minLines,
    this.keyboardType,
    this.autofocus,
    this.onChanged,
    thissuffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 16,
      ),
      onChanged: onChanged,
      cursorColor: Theme.of(context).colorScheme.primary,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.done,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      autocorrect: false,
      enableSuggestions: false,
      autofocus: autofocus ?? false,
      obscureText: false,
      enableInteractiveSelection: true,
      textCapitalization: TextCapitalization.none,
      controller: controller,
      readOnly: readOnly ?? false,
      onTap: onTap,

      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.transparent,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
