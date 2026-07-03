import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GenerateScreenFormCustomWidget extends StatefulWidget {
  const GenerateScreenFormCustomWidget({
    required this.onTap,
    required this.icon,
    required this.formChild,
    super.key,
    required this.title,
  });
  final void Function() onTap;
  final String title;
  final String icon;
  final Widget formChild;

  @override
  State<GenerateScreenFormCustomWidget> createState() =>
      _GenerateScreenFormCustomWidgetState();
}

class _GenerateScreenFormCustomWidgetState
    extends State<GenerateScreenFormCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        alignment: Alignment.center,
        // margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outline,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 4,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    SvgPicture.asset(
                      widget.icon,
                      width: 25,
                      height: 25,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: widget.onTap,
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.done_outline_rounded,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    IconButton(
                      onPressed: Navigator.of(context).pop,
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.outline,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.close_sharp,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(color: Theme.of(context).colorScheme.outlineVariant),
            SizedBox(height: 25),
            widget.formChild,
            SizedBox(height: 15),
          ],
        ),
      ),
    );
    //   ),
    // );
  }
}
