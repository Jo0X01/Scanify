import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActionButtonCustomWidget extends StatelessWidget {
  const ActionButtonCustomWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.quickBtn = true,
  });

  final VoidCallback onTap;
  final String label;
  final String icon;
  final bool quickBtn;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final btnWidgets = [
      SvgPicture.asset(
        icon,
        fit: BoxFit.fill,
        width: quickBtn ? 25 : 15,
        height: quickBtn ? 25 : 15,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.primary,
          BlendMode.srcIn,
        ),
      ),
      Text(
        label,
        overflow: TextOverflow.visible,
        softWrap: false,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    ];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: quickBtn ? w * 0.22 : double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
        ),
        child: quickBtn
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 4,
                children: btnWidgets,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: btnWidgets,
              ),
      ),
    );
  }
}
