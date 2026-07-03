// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:scanify/core/dialogs/app_dialogs.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/utils/validator.dart';
import 'package:scanify/features/generate/view/controller/tools/location_controller.dart';
import 'package:scanify/shared/location_picker/dialogs/location_picker_dialog.dart';
import 'package:scanify/shared/widgets/text_form_field_with_label_custom_widget.dart';

class LocationTemplate extends StatefulWidget {
  const LocationTemplate({super.key, required this.templateController});
  final LocationController templateController;

  @override
  State<LocationTemplate> createState() => _LocationTemplateeState();
}

class _LocationTemplateeState extends State<LocationTemplate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormFieldWithLabelCustomWidget(
          keyboardType: TextInputType.number,
          controller: widget.templateController.longController,
          validator: (val) => Validator.validateLongitude(val)?.message(context.l),
          hintText: context.l.enterLongitude,
          onSubmit: widget.templateController.updateCords,
          onChanged: widget.templateController.onChange,
        ),
        TextFormFieldWithLabelCustomWidget(
          keyboardType: TextInputType.number,
          controller: widget.templateController.latController,
          validator: (val) => Validator.validateLatitude(val)?.message(context.l),
          hintText: context.l.enterLatitude,
          onSubmit: widget.templateController.updateCords,
          onChanged: widget.templateController.onChange,
        ),
        Row(
          spacing: 8,
          children: [
            _buildBtn(
              context.l.pickLocation,
              () async => await LocationPickerDialog.show(
                context,
                initialValue: widget.templateController.result,
                onApply: widget.templateController.setCord,
                title: context.l.pickLocation,
                errorMsg: context.l.locationDialogError,
                confirmText: context.l.confirm,
                loadingText: context.l.loadingCurrentLocation,
                searchText: context.l.searchLocation,
              ),
            ),
            _buildBtn(context.l.pickMyLocation, () => _onPickMyLocation(context)),
          ],
        ),

        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.currentAddress,
          // hidden: widget.templateController.currentAddress.text.isEmpty,
          isTextBox: true,
          enabled: false,
          hintText: context.l.selectedAddressText,
        ),
      ],
    );
  }

  Widget _buildBtn(String title, VoidCallback onTap) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: BoxBorder.all(color: Theme.of(context).colorScheme.tertiary),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPickMyLocation(BuildContext context) async {
    AppDialogs.showLoading(context, context.l.loadingCurrentLocation);
    try {
      final result = await widget.templateController.loadCurrentLocation();
      if (!mounted) return;
      AppDialogs.hideLoading(context);
      AppDialogs.showNotifiyToast(context, switch (result) {
        LocationRequestState.permission => context.l.locationPermissionNotGranted,
        LocationRequestState.service => context.l.locationServiceDisabled,
        LocationRequestState.done => context.l.pickMyLocationSuccess,
        LocationRequestState.unknown => context.l.unknownLocation,
      });
    } finally {
      if (mounted) {
        AppDialogs.hideLoading(context);
      }
    }
  }
}
