import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/utils/validator.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/event_controller.dart'
    show EventController;
import 'package:qrcode_scanner_app/shared/widgets/text_form_field_with_label_custom_widget.dart';

class EventTemplate extends StatefulWidget {
  const EventTemplate({super.key, required this.templateController});

  final EventController templateController;

  @override
  State<EventTemplate> createState() => _EventTemplateState();
}

class _EventTemplateState extends State<EventTemplate> {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Column(
      spacing: 20,
      children: [
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.titleController,
          validator: (val) => Validator.validateName(val)?.message(l),
          labelText: l.eventTitle,
          hintText: l.eventEnterTitle,
        ),

        Row(
          spacing: 15,
          children: [
            _pickDate(
              labelText: l.eventStartDate,
              hintText: l.eventSelectStartDate,
              controller: widget.templateController.startDateController,
              l: l,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  currentDate: widget.templateController.currentSDate,
                  lastDate: DateTime(DateTime.now().year + 4),
                );
                widget.templateController.onPickSDate(date);
              },
            ),
            _pickDate(
              labelText: l.eventEndDate,
              hintText: l.eventSelectEndDate,
              controller: widget.templateController.endDateController,
              l: l,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: widget.templateController.currentSDate,
                  currentDate: widget.templateController.currentEDate,
                  lastDate: DateTime(DateTime.now().year + 4),
                );
                widget.templateController.onPickEDate(date);
              },
            ),
          ],
        ),

        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.locationController,
          validator: (val) => Validator.validateContent(val)?.message(l),
          labelText: l.eventLocation,
          hintText: l.eventEnterLocation,
        ),

        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.descController,
          validator: (val) => Validator.validateContent(val)?.message(l),
          labelText: l.eventDescription,
          hintText: l.eventEnterDescription,
          isTextBox: true,
        ),
      ],
    );
  }

  Widget _pickDate({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    required VoidCallback onTap,
    required AppLocalizations l,
  }) {
    return Flexible(
      child: GestureDetector(
        onTap: onTap,
        child: TextFormFieldWithLabelCustomWidget(
          controller: controller,
          enabled: false,
          labelText: labelText,
          hintText: hintText,
          validator: (val) => Validator.validateDate(
            widget.templateController.getDateTimeValue(val),
          )?.message(l),
        ),
      ),
    );
  }
}
