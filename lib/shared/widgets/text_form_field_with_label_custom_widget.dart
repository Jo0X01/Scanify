import 'package:flutter/material.dart';
import 'package:qrcode_scanner_app/core/constants/app_colors.dart';

// ignore: must_be_immutable
class TextFormFieldWithLabelCustomWidget extends StatefulWidget {
  final TextInputType keyboardType;
  final String? hintText;
  bool obscureText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function()? onChanged;
  final void Function()? onSubmit;
  final String? labelText;
  final bool? isTextBox;
  final bool? enabled;
  final bool? hidden;

  TextFormFieldWithLabelCustomWidget({
    required this.controller,
    this.validator,
    this.enabled,
    this.hidden,
    this.isTextBox,
    this.labelText,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPassword = false,
    super.key,
    this.onChanged,
    this.onSubmit,
  });

  @override
  State<TextFormFieldWithLabelCustomWidget> createState() =>
      _TextFormFieldWithLabelCustomWidgetState();
}

class _TextFormFieldWithLabelCustomWidgetState
    extends State<TextFormFieldWithLabelCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return (widget.hidden != null && widget.hidden == true)
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.labelText == null
                  ? const SizedBox()
                  : Text(
                      widget.labelText!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        // color: AppColors.onPrimary
                      ),
                    ),
              SizedBox(height: widget.labelText == null ? 0 : 5),
              TextFormField(
                onEditingComplete: widget.onSubmit,
                onChanged: (_) => widget.onChanged?.call(),
                enabled: widget.enabled,
                maxLines: widget.isTextBox != null ? 5 : 1,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  // color: AppColors.onPrimary,
                  overflow: TextOverflow.ellipsis,
                ),
                obscureText: widget.obscureText,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                  ),
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          icon: Icon(
                            widget.obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xff454A4F),
                            size: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.obscureText = !widget.obscureText;
                            });
                          },
                        )
                      : null,

                  contentPadding: const EdgeInsets.all(15),
                  enabledBorder: outlineInputBorder(
                    color: Color(0xffBABABA),
                    radius: 10,
                    width: 1,
                  ),
                  focusedBorder: outlineInputBorder(
                    color: AppColors.iconColor,
                    radius: 10,
                    width: 1,
                  ),
                  errorBorder: outlineInputBorder(
                    color: Colors.red,
                    radius: 10,
                    width: 1,
                  ),
                  focusedErrorBorder: outlineInputBorder(
                    color: Colors.red,
                    radius: 10,
                    width: 1,
                  ),
                ),
                keyboardType: widget.keyboardType,
                controller: widget.controller,
                validator: widget.validator,
              ),
            ],
          );
  }

  OutlineInputBorder outlineInputBorder({
    required double radius,
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
