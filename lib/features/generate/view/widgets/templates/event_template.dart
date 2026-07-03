import 'package:flutter/material.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/utils/validator.dart';
import 'package:scanify/features/generate/view/controller/tools/event_controller.dart'
    show EventController;
import 'package:scanify/shared/widgets/text_form_field_with_label_custom_widget.dart';

class EventTemplate extends StatefulWidget {
  const EventTemplate({super.key, required this.templateController});

  final EventController templateController;

  @override
  State<EventTemplate> createState() => _EventTemplateState();
}

class _EventTemplateState extends State<EventTemplate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.titleController,
          validator: (val) => Validator.validateName(val)?.message(context.l),
          labelText: context.l.eventTitle,
          hintText: context.l.eventEnterTitle,
        ),

        Row(
          spacing: 15,
          children: [
            _pickDate(
              labelText: context.l.eventStartDate,
              hintText: context.l.eventSelectStartDate,
              controller: widget.templateController.startDateController,
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
              labelText: context.l.eventEndDate,
              hintText: context.l.eventSelectEndDate,
              controller: widget.templateController.endDateController,
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
          validator: (val) =>
              Validator.validateContent(val)?.message(context.l),
          labelText: context.l.eventLocation,
          hintText: context.l.eventEnterLocation,
        ),

        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.descController,
          validator: (val) =>
              Validator.validateContent(val)?.message(context.l),
          labelText: context.l.eventDescription,
          hintText: context.l.eventEnterDescription,
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
          )?.message(context.l),
        ),
      ),
    );
  }
}
