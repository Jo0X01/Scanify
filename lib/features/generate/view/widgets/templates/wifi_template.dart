import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/l10n/app_localizations.dart';
import 'package:qrcode_scanner_app/core/utils/validator.dart';
import 'package:qrcode_scanner_app/features/generate/view/controller/tools/wifi_controller.dart';
import 'package:qrcode_scanner_app/shared/widgets/text_form_field_with_label_custom_widget.dart';

class WifiTemplate extends StatefulWidget {
  const WifiTemplate({super.key, required this.templateController});
  final WifiController templateController;

  @override
  State<WifiTemplate> createState() => _WifiTemplateState();
}

class _WifiTemplateState extends State<WifiTemplate> {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      spacing: 20,
      children: [
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.ssidController,
          validator: (val) => Validator.validateName(val)?.message(l),
          hintText: l.wifiEnterNetworkName,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.passwordController,
          validator: (value) => Validator.validateWifiPassword(
            value,
            widget.templateController.security,
            l,
          ),
          hintText: l.wifiEnterNetworkPassword,
          isPassword: true,
        ),
        Row(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: widget.templateController.isHiddenListener,
              builder: (context, value, child) {
                return Checkbox(
                  value: widget.templateController.isHidden,
                  onChanged: widget.templateController.setHidden,
                );
              },
            ),
            Text(l.wifiIsHiddenLabel),
          ],
        ),
        const Divider(color: AppColors.lIconColor),
        Column(
          children: [
            Text(l.wifiSelectSecurity),
            ValueListenableBuilder(
              valueListenable: widget.templateController.securityListener,
              builder: (context, value, child) {
                return DropdownButton(
                  hint: Text(l.wifiSelectSecurity),
                  value: widget.templateController.security,
                  items: widget.templateController.avaliableSecurityList
                      .map(
                        (ele) => DropdownMenuItem(value: ele, child: Text(ele)),
                      )
                      .toList(),
                  onChanged: widget.templateController.setSecurity,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
