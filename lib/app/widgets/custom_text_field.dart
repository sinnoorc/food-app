import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.label,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.isSuffixIcon = false,
      this.validator})
      : super(key: key);

  final String label;

  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool isSuffixIcon;
  final String? Function(String?)? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  RxBool isObscureText = false.obs;

  @override
  void initState() {
    isObscureText.value = widget.obscureText;
    super.initState();
  }

  passwordVisible() {
    isObscureText.value = !isObscureText.value;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.label, style: theme.textTheme.caption),
        const SizedBox(height: 10),
        Obx(() => TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: isObscureText.value,
              validator: widget.validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: theme.primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(style: BorderStyle.none),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: theme.errorColor),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: theme.errorColor),
                ),
                isDense: true,
                filled: true,
                fillColor: Colors.white70,
                suffixIcon: Visibility(
                  visible: widget.isSuffixIcon,
                  child: IconButton(
                    icon: Icon(
                      isObscureText.value ? Icons.visibility : Icons.visibility_off,
                      color: theme.primaryColor,
                    ),
                    onPressed: passwordVisible,
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
