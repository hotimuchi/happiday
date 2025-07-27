import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

        leading: Icon(icon, color: theme.primary),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)).tr(),
        subtitle: subtitle != null ? Text(subtitle!).tr() : null,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
