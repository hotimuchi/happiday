import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Note extends StatefulWidget {
  final String? initialText;
  const Note({super.key, this.initialText});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final nameFocusNode = FocusNode();
  final noteController = TextEditingController();

  @override
  void initState() {
    noteController.text = widget.initialText ?? '';
    Future.delayed(Duration(milliseconds: 0), () {
      if (mounted) {
        FocusScope.of(context).requestFocus(nameFocusNode);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.pop(noteController.text);
                        },
                        style: ButtonStyle(
                          foregroundColor: WidgetStateProperty.all(
                            noteController.text.isNotEmpty
                                ? theme.primary
                                : theme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                        child:
                            Text(
                              'done',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ).tr(),
                      ),

                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  Text(
                    'note'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 200,
              child: TextFormField(
                onChanged: (_) => setState(() {}),
                controller: noteController,
                focusNode: nameFocusNode,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
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
    );
  }
}
