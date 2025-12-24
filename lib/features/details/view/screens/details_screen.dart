import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/constants/app_strings.dart';
import 'package:qrcode_scanner_app/core/dialogs/app_dialogs.dart';
import 'package:qrcode_scanner_app/core/dialogs/app_toasts.dart';
import 'package:qrcode_scanner_app/core/widgets/custom_back_appbar.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  static const String routeName = AppRoutes.detailsScreen;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final qrData = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: CustomBackAppBar(title: AppStrings.details),
      body: Column(
        spacing: 10,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            decoration: BoxDecoration(
              color: AppColors.tabBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              spacing: 20,
              children: [
                Text(
                  qrData,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Divider(height: 2,thickness: 3,color: AppColors.iconColor,),
                Screenshot(
                  controller: _saveController,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.secondary,
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: QrImageView(
                      data: qrData,
                      size: 220,
                      embeddedImage: AssetImage(AppImages.appLogo),
                      backgroundColor: AppColors.background,
                      version: _defaultQRCodeVersion,
                      errorCorrectionLevel: QrErrorCorrectLevel.M,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            clipBehavior: Clip.none,
            spacing: 10,
            children: [
              _actionButton(AppIcons.shareIcon, AppStrings.share,
                  onTap: () => _share(qrData)),
              _actionButton(
                AppIcons.copyIcon,
                AppStrings.copy,
                onTap: () => _copyToClipboard(qrData),
              ),
              _actionButton(
                AppIcons.saveIcon,
                AppStrings.save,
                onTap: () => _save(qrData),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    String icon,
    String actionTitle, {
    void Function()? onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(
              icon,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                AppColors.tabBackgroundColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Text(actionTitle),
      ],
    );
  }

  void _copyToClipboard(String data) async {
    AppDialogs.showSnackBar(context, "Copying...");
    await Clipboard.setData(ClipboardData(text: data));
    AppDialogs.showSnackBar(context, "Saved to clipboard");
  }

  void _share(String data) async {
    AppDialogs.showSnackBar(context, "Sharing...");
    try{
      final tempDir = await getTemporaryDirectory();
      final image = await _saveController.captureAndSave(tempDir.path,fileName: AppStrings.tempShareQRFileName);
      final xFile = XFile(image!);
      final result = await SharePlus.instance.share(ShareParams(files: [xFile]));
      if(result.status == ShareResultStatus.success){
        AppDialogs.showSnackBar(context, "Done");
      }
    }catch(e){
      AppToast.warn(context,title: "Error",description: e.toString());
    }
  }

  void _save(String data) async {
    AppDialogs.showSnackBar(context, "Saving...");
    await _saveController.captureAndSave(AppStrings.cameraPath);
    AppDialogs.showSnackBar(context, "Saved to: ${AppStrings.cameraPath}");
  }

  late final ScreenshotController _saveController;
  late final int _defaultQRCodeVersion;
  @override
  void initState() {
    super.initState();
    _saveController = ScreenshotController();
    _defaultQRCodeVersion = QrVersions.isSupportedVersion(7) ? 7 : QrVersions.auto;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
