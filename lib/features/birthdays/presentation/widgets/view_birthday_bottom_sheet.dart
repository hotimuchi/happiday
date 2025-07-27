import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../widget/app_bottom_sheet.dart';
import '../../../../widget/app_widget_snackbar.dart';
import '../../domain/entities/birthday.dart';
import '../bloc/birthdays_bloc.dart';
import 'calendar.dart';
import 'note.dart';

class ViewBirthdayBottomSheet extends StatefulWidget {
  final Birthday birthday;
  const ViewBirthdayBottomSheet({super.key, required this.birthday});

  @override
  State<ViewBirthdayBottomSheet> createState() =>
      _ViewBirthdayBottomSheetState();
}

class _ViewBirthdayBottomSheetState extends State<ViewBirthdayBottomSheet> {
  final nameController = TextEditingController();
  final nameFocusNode = FocusNode();
  String? note;

  DateTime? selectedDate;

  @override
  void initState() {
    nameController.text = widget.birthday.name;
    selectedDate = widget.birthday.birthday;
    note = widget.birthday.note;

    Future.delayed(Duration(milliseconds: 0), () {
      if (mounted) {
        FocusScope.of(context).requestFocus(nameFocusNode);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 0),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'edit'.tr(),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: TextFormField(
                          controller: nameController,
                          focusNode: nameFocusNode,
                          maxLines: 10,
                          keyboardType: TextInputType.twitter,

                          autofocus: true,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          child: Text(
                            selectedDate == null
                                ? 'choose_date'.tr()
                                : DateFormat.yMMMd(
                                  context.locale.toString(),
                                ).format(selectedDate!),
                            style: TextStyle(
                              color:
                                  selectedDate != null
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurface
                                          .withValues(alpha: 0.5),
                            ),
                          ),
                          onPressed:
                              () => appBottomSheet(
                                context,
                                Calendar(
                                  focusedDay: selectedDate ?? DateTime.now(),
                                  selectedDay: selectedDate,
                                  events: const {},
                                  onDaySelected: (selected, focused) {
                                    if (mounted) {
                                      setState(() {
                                        selectedDate = selected;
                                      });
                                      context.pop();
                                    }
                                  },
                                ),
                                size: 0.6,
                              ),
                        ),

                        IconButton(
                          icon: Icon(
                            Icons.notes,
                            color:
                                (note != null && note!.isNotEmpty)
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface
                                        .withValues(alpha: 0.5),
                          ),
                          onPressed: () async {
                            final result = await appBottomSheet(
                              context,
                              Note(initialText: note),
                              size: 0.9,
                            );
                            if (mounted && result != null && result is String) {
                              setState(() {
                                note = result;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<BirthdaysBloc>().add(
                          DeleteBirthday(widget.birthday.id),
                        );
                        context.pop();
                      },
                      child: Text(
                        'delete'.tr(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              InkWell(
                onTap: () {
                  if (nameController.text.isEmpty || selectedDate == null) {
                    appWidgetSnackBar(
                      context,
                      Colors.red,
                      'enter_name_and_choose_date'.tr(),
                    );
                    context.pop();
                    return;
                  }

                  final birthday = Birthday(
                    id: widget.birthday.id,
                    name: nameController.text,
                    birthday: selectedDate!,
                    note: note,
                  );
                  context.read<BirthdaysBloc>().add(UpdateBirthday(birthday));
                  context.pop();
                },
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child:
                        Text(
                          'save',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ).tr(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
