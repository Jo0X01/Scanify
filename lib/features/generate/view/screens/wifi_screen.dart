import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/constants/app_strings.dart';
import 'package:qrcode_scanner_app/core/utils/app_helpers.dart';
import 'package:qrcode_scanner_app/core/utils/validator.dart';
import 'package:qrcode_scanner_app/shared/widgets/text_form_field_with_label_custom_widget.dart';
import 'package:qrcode_scanner_app/features/generate/view/widgets/generate_screen_form_custom_widget.dart';

class WifiScreen extends StatefulWidget {
  const WifiScreen({super.key});

  static const String routeName = AppRoutes.wifiScreen;
  @override
  State<WifiScreen> createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: wifiFormKey,
      child: GenerateScreenFormCustomWidget(
        icon: AppIcons.wifiIcon,
        onTap: _onQRGenerating,
        formChild: Column(
          spacing: 20,
          children: [
            TextFormFieldWithLabelCustomWidget(
              controller: wifiNameController,
              validator: Validator.validateName,
              labelText: "Enter Network Name",
            ),
            TextFormFieldWithLabelCustomWidget(
              controller: wifiPasswordController,
              validator: Validator.validatePassword,
              labelText: "Enter Network Password",
              isPassword: true,
            ),
            Row(
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: isHidden,
                  builder: (context, value, child) {
                    return Checkbox(
                      value: isHidden.value,
                      onChanged: (value) => isHidden.value = value ?? false,
                    );
                  },
                ),
                Text("is Hidden Network"),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: wifiSecurityController,
              builder: (context, value, child) {
                return DropdownButton(
                  hint: Text("Select Security"),
                  value: wifiSecurityController.value,
                  items: AppStrings.wifiSecurityList
                      .map(
                        (ele) => DropdownMenuItem(value: ele, child: Text(ele)),
                      )
                      .toList(),
                  onChanged: (val) => wifiSecurityController.value =
                      val ?? AppStrings.wifiSecurityList[0],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onQRGenerating() {
    if (wifiFormKey.currentState?.validate() ?? false) {
      AppRoutes.replaceWith(
        context,
        AppRoutes.detailsScreen,
        arguments: AppHelpers.fixQRString(
          AppStrings.wifiQRPattern, {
            "S": wifiNameController.text,
            "P": wifiPasswordController.text,
            "T": wifiSecurityController.value,
            "H": isHidden.value.toString(),
          }
        )
      );
    }
  }

  late GlobalKey<FormState> wifiFormKey;
  late TextEditingController wifiNameController;
  late TextEditingController wifiPasswordController;
  late ValueNotifier<String> wifiSecurityController;
  late ValueNotifier<bool> isHidden;

  @override
  void initState() {
    super.initState();
    wifiFormKey = GlobalKey<FormState>();
    wifiNameController = TextEditingController();
    wifiPasswordController = TextEditingController();
    wifiSecurityController = ValueNotifier(AppStrings.wifiSecurityList.first);
    isHidden = ValueNotifier(false);
  }

  @override
  void dispose() {
    wifiNameController.dispose();
    wifiPasswordController.dispose();
    wifiSecurityController.dispose();
    isHidden.dispose();
    super.dispose();
  }
}
