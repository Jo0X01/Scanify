import 'package:flutter/material.dart';

class SearchBarCustomWidget extends StatelessWidget {
  const SearchBarCustomWidget({
    super.key,
    this.controller,
    this.enabled,
    this.onChange,
    this.enableFilter,
    this.onFilter,
    this.hintText,
    this.margin,
  });
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final bool? enabled;
  final void Function(String)? onChange;
  final bool? enableFilter;
  final void Function()? onFilter;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: margin,
      child: SearchBar(
        autoFocus: false,
        leading: Icon(Icons.search, size: 30),
        controller: controller,
        enabled: enabled ?? true,
        onChanged: onChange,
        trailing: [
          enableFilter ?? false
              ? GestureDetector(
                  onTap: onFilter,
                  child: Icon(Icons.filter_alt_outlined, size: 30),
                )
              : const SizedBox.shrink(),
        ],
        hintText: hintText,
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.outline,
        ),
        hintStyle: WidgetStatePropertyAll(
          Theme.of(context).textTheme.labelMedium,
        ),
        shadowColor: WidgetStateColor.transparent,
      ),
    );
  }
}
