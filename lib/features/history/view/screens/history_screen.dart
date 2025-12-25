import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrcode_scanner_app/core/constants/app_assets.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';
import 'package:qrcode_scanner_app/core/constants/app_routes.dart';
import 'package:qrcode_scanner_app/core/constants/app_strings.dart';
import 'package:qrcode_scanner_app/core/models/qrcode_model.dart';
import 'package:qrcode_scanner_app/core/utils/app_helpers.dart';
import 'package:qrcode_scanner_app/core/utils/app_hive.dart';
import 'package:qrcode_scanner_app/core/widgets/custom_back_appbar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  static const String routeName = AppRoutes.historyScreen;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(
        title: AppStrings.history,
        hasBack: false,
        addSettings: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        margin: EdgeInsets.only(left: 15,right: 15,bottom: 160),
        decoration: BoxDecoration(
          color: AppColors.tabBackgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: storedQRData.isEmpty
            ? Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 60),
                child: Column(
                  spacing: 10,
                  children: [
                    SvgPicture.asset(
                      AppIcons.emptyIcon,
                      width: 120,
                      height: 120,
                    ),
                    Text(
                      "No QRCode Scanned/Generated",
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      "Try to scan/generate",
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: storedQRData.length,
                itemBuilder: (context, index) => _qrItemCard(index),
              ),
      ),
    );
  }

  late List<HistoryQRCodeModel> storedQRData = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    storedQRData = await AppHiveUtils.getStoredQRs();
    setState(() {});
  }

  Widget _qrItemCard(int index) {
    return GestureDetector(
      onTap: () => AppRoutes.navigateTo(
        context,
        AppRoutes.detailsScreen,
        arguments: storedQRData[index],
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColors.tabBackgroundColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray,
              blurRadius: 3,
              spreadRadius: 1.2,
              offset: Offset(0, 0),
              blurStyle: BlurStyle.outer
            )
          ]
        ),
      
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            SvgPicture.asset(AppIcons.appIcon, width: 36, height: 36),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    storedQRData[index].data!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    storedQRData[index].type ?? "text",
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 10,
              children: [
                GestureDetector(
                  onTap: () => _onDelete(index),
                  child: SvgPicture.asset(
                    AppIcons.trashIcon,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      AppColors.secondary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Text(
                  AppHelpers.getCleanDate(storedQRData[index].date),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onDelete(int index) async {
    final item = storedQRData[index];
    if (await AppHiveUtils.removeQRCode(item.id)) {
      getData();
    }
  }
}
