// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/dialogs/app_dialogs.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/utils/validator.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/location_controller.dart';
import 'package:qrcode_scanner_app/shared/location_picker/dialogs/location_picker_dialog.dart';
import 'package:qrcode_scanner_app/shared/widgets/text_form_field_with_label_custom_widget.dart';

class LocationTemplate extends StatefulWidget {
  const LocationTemplate({super.key, required this.templateController});
  final LocationController templateController;

  @override
  State<LocationTemplate> createState() => _LocationTemplateeState();
}

class _LocationTemplateeState extends State<LocationTemplate> {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      spacing: 20,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.longController,
          validator: (val) => Validator.validateLongitude(val)?.message(l),
          hintText: l.enterLongitude,
          onSubmit: widget.templateController.updateCords,
          onChanged: widget.templateController.onChange,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.latController,
          validator: (val) => Validator.validateLatitude(val)?.message(l),
          hintText: l.enterLatitude,
          onSubmit: widget.templateController.updateCords,
          onChanged: widget.templateController.onChange,
        ),
        Row(
          spacing: 8,
          children: [
            _buildBtn(
              l.pickLocation,
              () async => await LocationPickerDialog.show(
                context,
                initialValue: widget.templateController.result,
                onApply: widget.templateController.setCord,
                title: l.pickLocation,
                errorMsg: l.locationDialogError,
                confirmText: l.confirm,
                loadingText: l.loadingCurrentLocation,
                searchText: l.searchLocation,
              ),
            ),
            _buildBtn(l.pickMyLocation, () => _onPickMyLocation(context, l)),
          ],
        ),

        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.currentAddress,
          // hidden: widget.templateController.currentAddress.text.isEmpty,
          isTextBox: true,
          enabled: false,
          hintText: l.selectedAddressText,
        ),
      ],
    );
  }

  Widget _buildBtn(String title, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: BoxBorder.all(color: AppColors.textSecondary),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Text(title, style: Theme.of(context).textTheme.titleSmall),
        ),
      ),
    );
  }

  void _onPickMyLocation(BuildContext context, AppLocalizations l) async {
    AppDialogs.showLoading(context, l.loadingCurrentLocation);
    final result = await widget.templateController.loadCurrentLocation();
    if (!mounted) return;
    AppDialogs.hideLoading(context);
    AppDialogs.showSnackBar(context, switch (result) {
      LocationRequestState.permission => l.locationPermissionNotGranted,
      LocationRequestState.service => l.locationServiceDisabled,
      LocationRequestState.done => l.pickMyLocationSuccess,
      LocationRequestState.unknown => l.unknownLocation,
    });
  }
}
