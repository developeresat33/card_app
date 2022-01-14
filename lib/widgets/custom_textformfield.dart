import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum BorderType { FLAT, ROUNDED }
enum Type { OUTLINED, UNDERLINED }

//Proje boyunca kullandığımız metin aracı.

class CustomTextFormField extends StatelessWidget {
  final bool readOnly;
  final Function onTap;
  final String placeholder;
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String val) validator;
  final List<TextInputFormatter> inputFormatters;
  final void Function(String val) onChanged;
  final TextCapitalization textCapitalization;
  final InputDecoration decoration;
  final BorderType borderType;
  final int maxLength;
  final bool obscureText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool enabled;
  final int maxLines;
  final int minLines;
  final AutovalidateMode autoValidate;
  final String initialValue;
  final Type type;
  final Function onEditingComplete;

  const CustomTextFormField({
    Key key,
    this.onEditingComplete,
    this.readOnly = false,
    this.placeholder,
    this.type = Type.OUTLINED,
    this.hintText,
    this.controller,
    this.focusNode,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.textCapitalization,
    this.minLines,
    this.initialValue,
    this.maxLines = 1,
    this.decoration,
    this.maxLength,
    this.obscureText,
    this.textInputType,
    this.textInputAction,
    this.enabled = true,
    this.autoValidate,
    this.borderType = BorderType.ROUNDED,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      autocorrect: false,
      readOnly: readOnly ?? false,
      autovalidateMode: autoValidate,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      cursorColor: Color.fromRGBO(50, 205, 50, 1),
      inputFormatters: inputFormatters,
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      enabled: enabled,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      initialValue: initialValue,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        alignLabelWithHint: false,
        labelStyle: TextStyle(
          color: Colors.black87,
        ),
        hintStyle: TextStyle(
          color: Color.fromRGBO(50, 205, 50, 1),
        ),
        floatingLabelBehavior:
            decoration != null && decoration.floatingLabelBehavior != null
                ? decoration.floatingLabelBehavior
                : null,
        fillColor: decoration != null && decoration.fillColor != null
            ? decoration.fillColor
            : null,
        filled: decoration != null && decoration.filled != null
            ? decoration.filled
            : false,
        hintText: hintText ?? '',
        prefix: decoration != null && decoration.prefix != null
            ? decoration.prefix
            : null,
        prefixIcon: decoration != null && decoration.prefixIcon != null
            ? decoration.prefixIcon
            : null,
        suffix: decoration != null && decoration.suffix != null
            ? decoration.suffix
            : null,
        suffixIcon: decoration != null && decoration.suffixIcon != null
            ? decoration.suffixIcon
            : null,
        labelText: '$placeholder',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color(0xff32CD32),
          ),
        ),
        enabledBorder: decoration != null && decoration.enabledBorder != null
            ? decoration.enabledBorder
            : type != Type.OUTLINED
                ? null
                : OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black45),
                    borderRadius: borderType == BorderType.FLAT
                        ? BorderRadius.circular(0)
                        : BorderRadius.circular(6),
                  ),
        errorBorder: decoration != null && decoration.errorBorder != null
            ? decoration.errorBorder
            : type != Type.OUTLINED
                ? null
                : OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.red),
                    borderRadius: borderType == BorderType.FLAT
                        ? BorderRadius.circular(0)
                        : BorderRadius.circular(6),
                  ),
        focusedErrorBorder:
            decoration != null && decoration.focusedErrorBorder != null
                ? decoration.focusedErrorBorder
                : type != Type.OUTLINED
                    ? null
                    : OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.red),
                        borderRadius: borderType == BorderType.FLAT
                            ? BorderRadius.circular(0)
                            : BorderRadius.circular(6),
                      ),
        disabledBorder: decoration != null && decoration.disabledBorder != null
            ? decoration.disabledBorder
            : type != Type.OUTLINED
                ? null
                : OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black26),
                    borderRadius: borderType == BorderType.FLAT
                        ? BorderRadius.circular(0)
                        : BorderRadius.circular(10),
                  ),
        enabled: decoration != null && decoration.enabled != null
            ? decoration.enabled
            : true,
        counterText: "",
      ),
    );
  }
}
