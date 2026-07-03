import 'package:flutter/material.dart';

class TextFormFieldWithLabelCustomWidget extends StatefulWidget {
  const TextFormFieldWithLabelCustomWidget({
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
    this.onChanged,
    this.onSubmit,
    super.key,
  });

  final TextInputType keyboardType;
  final String? hintText;
  final bool obscureText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String value)? onChanged;
  final void Function()? onSubmit;
  final String? labelText;
  final bool? isTextBox;
  final bool? enabled;
  final bool? hidden;

  @override
  State<TextFormFieldWithLabelCustomWidget> createState() =>
      _TextFormFieldWithLabelCustomWidgetState();
}

class _TextFormFieldWithLabelCustomWidgetState
    extends State<TextFormFieldWithLabelCustomWidget> {
  late final FocusNode _focusNode;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hidden == true) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 5),
        ],
        TextFormField(
          focusNode: _focusNode,
          autofocus: false,
          controller: widget.controller,
          validator: widget.validator,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
          maxLines: _obscureText ? 1 : (widget.isTextBox == true ? 5 : 1),
          onEditingComplete: widget.onSubmit,
          onChanged: widget.onChanged,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
              overflow: TextOverflow.ellipsis,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xff454A4F),
                      size: 24,
                    ),
                    onPressed: () => setState(() {
                      _obscureText = !_obscureText;
                    }),
                  )
                : null,
            contentPadding: const EdgeInsets.all(15),
            enabledBorder: _border(color: const Color(0xffBABABA)),
            focusedBorder: _border(color: const Color(0xffBABABA)),
            errorBorder: _border(color: Colors.red),
            focusedErrorBorder: _border(color: Colors.red),
            disabledBorder: _border(color: const Color(0xffBABABA)),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}
