import 'package:flutter/material.dart';
import 'package:scanify/core/extensions/context_addons_extension.dart';
import 'package:scanify/core/utils/validator.dart';
import 'package:scanify/features/generate/view/controller/tools/wifi_controller.dart';
import 'package:scanify/shared/widgets/text_form_field_with_label_custom_widget.dart';

class WifiTemplate extends StatefulWidget {
  const WifiTemplate({super.key, required this.templateController});
  final WifiController templateController;

  @override
  State<WifiTemplate> createState() => _WifiTemplateState();
}

class _WifiTemplateState extends State<WifiTemplate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.ssidController,
          validator: (val) => Validator.validateName(val)?.message(context.l),
          hintText: context.l.wifiEnterNetworkName,
        ),
        TextFormFieldWithLabelCustomWidget(
          controller: widget.templateController.passwordController,
          validator: (value) => Validator.validateWifiPassword(
            value,
            widget.templateController.security.label,
            context.l,
          ),
          hintText: context.l.wifiEnterNetworkPassword,
          isPassword: true,
        ),
        GestureDetector(
          onTap: () => widget.templateController.setHidden(
            !widget.templateController.isHidden,
          ),
          child: Row(
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
              Text(context.l.wifiIsHiddenLabel),
            ],
          ),
        ),
        Row(
          spacing: 10,
          children: [
            Text(context.l.wifiSelectSecurity),
            ValueListenableBuilder(
              valueListenable: widget.templateController.securityListener,
              builder: (context, value, child) {
                return DropdownButton(
                  hint: Text(context.l.wifiSelectSecurity),
                  value: widget.templateController.security,
                  items: [
                    DropdownMenuItem(
                      value: WifiProtection.nopass,
                      child: Text(context.l.noWifiProtection),
                    ),
                    DropdownMenuItem(
                      value: WifiProtection.wep,
                      child: Text(WifiProtection.wep.label),
                    ),
                    DropdownMenuItem(
                      value: WifiProtection.wpa,
                      child: Text(WifiProtection.wpa.label),
                    ),
                  ],
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
