import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/repositories/settings_repository.dart';
import 'settings_card.dart';

class NotificationTimeCard extends StatefulWidget {
  const NotificationTimeCard({super.key});

  @override
  State<NotificationTimeCard> createState() => _NotificationTimeCardState();
}

class _NotificationTimeCardState extends State<NotificationTimeCard> {
  TimeOfDay? _selectedTime;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadTime();
  }

  Future<void> _loadTime() async {
    setState(() => _loading = true);
    final repo = sl<SettingsRepository>();
    final time = await repo.getNotificationTime();
    setState(() {
      _selectedTime = time ?? const TimeOfDay(hour: 9, minute: 0);
      _loading = false;
    });
  }

  Future<void> _pickTime() async {
    TimeOfDay tempTime = _selectedTime ?? const TimeOfDay(hour: 9, minute: 0);
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 180,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime(
                    0,
                    0,
                    0,
                    tempTime.hour,
                    tempTime.minute,
                  ),
                  use24hFormat: true,
                  onDateTimeChanged: (dateTime) {
                    tempTime = TimeOfDay(
                      hour: dateTime.hour,
                      minute: dateTime.minute,
                    );
                  },
                ),
              ),
              const Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('cancel').tr(),
                  ),
                  const Gap(8),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() => _selectedTime = tempTime);
                      final repo = sl<SettingsRepository>();
                      await repo.saveNotificationTime(tempTime);
                      if (!context.mounted) return;
                      context.pop();
                    },
                    child: const Text('ok').tr(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      icon: Icons.notifications_rounded,
      title: 'notifications',
      subtitle: 'manage_notifications',
      trailing:
          _loading
              ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
              : TextButton(
                onPressed: _pickTime,
                child: Text(
                  _selectedTime != null
                      ? _selectedTime!.format(context)
                      : '--:--',
                ),
              ),
    );
  }
}
