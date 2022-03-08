import 'package:card_application/utils/colors.dart';
import 'package:flutter/material.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key key, this.isSelected = false, this.language})
      : super(key: key);
  final String language;
  final bool isSelected;

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.isSelected
          ? Icon(
              Icons.check,
              color: WAPrimaryColor,
            )
          : Icon(Icons.remove),
      title: Text(widget.language),
    );
  }
}
