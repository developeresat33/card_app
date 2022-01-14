import 'package:flutter/material.dart';

//Tasarımsal olarak ortak kullandığımız özel oluşturulan bir materyal buton.

class CustomMaterialButton extends StatefulWidget {
  final Function onPressed;
  final Function onLongPress;
  final Function(bool) onHighlightChanged;
  final MouseCursor mouseCursor;
  final ButtonTextTheme buttonTextTheme;
  final Color textColor;
  final Color disabledTextColor;
  final Color color;
  final Color disabledColor;
  final Color focusColor;
  final Color hoverColor;
  final Color highlightColor;
  final Color splashColor;
  final Brightness colorBrightness;
  final double elevation;
  final double focusElevation;
  final double hoverElevation;
  final double highlightElevation;
  final double disabledElevation;
  final EdgeInsetsGeometry padding;
  final VisualDensity visualDensity;
  final ShapeBorder shape;
  final Clip clipBehavior = Clip.none;
  final FocusNode focusNode;
  final bool autofocus = false;
  final MaterialTapTargetSize materialTapTargetSize;
  final Duration animationDuration;
  final double minWidth;
  final double height;
  final bool enableFeedback = true;
  final Widget child;
  final bool isProgress;
  final String label;

  const CustomMaterialButton(
      {Key key,
      this.onPressed,
      this.onLongPress,
      this.onHighlightChanged,
      this.mouseCursor,
      this.buttonTextTheme,
      this.textColor,
      this.disabledTextColor,
      this.color,
      this.disabledColor,
      this.focusColor,
      this.hoverColor,
      this.highlightColor,
      this.splashColor,
      this.colorBrightness,
      this.elevation,
      this.focusElevation,
      this.hoverElevation,
      this.highlightElevation,
      this.disabledElevation,
      this.padding,
      this.visualDensity,
      this.shape,
      this.focusNode,
      this.materialTapTargetSize,
      this.animationDuration,
      this.minWidth,
      this.height,
      this.child,
      this.isProgress = false,
      this.label = ""})
      : super(key: key);

  @override
  _CustomMaterialButtonState createState() => _CustomMaterialButtonState();
}

class _CustomMaterialButtonState extends State<CustomMaterialButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      onHighlightChanged: widget.onHighlightChanged,
      mouseCursor: widget.mouseCursor,
      textTheme: widget.buttonTextTheme,
      textColor: widget.textColor,
      disabledColor: widget.disabledColor,
      disabledTextColor: widget.disabledTextColor,
      color: Color(0xffff2d55),
      focusColor: widget.focusColor,
      hoverColor: widget.hoverColor,
      highlightColor: widget.highlightColor,
      splashColor: widget.splashColor,
      colorBrightness: widget.colorBrightness,
      elevation: widget.elevation,
      focusElevation: widget.focusElevation,
      hoverElevation: widget.hoverElevation,
      highlightElevation: widget.highlightElevation,
      disabledElevation: widget.disabledElevation,
      padding: widget.padding,
      visualDensity: widget.visualDensity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: widget.clipBehavior,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      materialTapTargetSize: widget.materialTapTargetSize,
      animationDuration: widget.animationDuration,
      minWidth: widget.minWidth,
      height: widget.height,
      enableFeedback: widget.enableFeedback,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.isProgress
              ? Expanded(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                ))
              : SizedBox.shrink(),
          widget.isProgress
              ? Expanded(
                  child: Text(
                  widget.label,
                  style: TextStyle(color: Colors.white),
                ))
              : Text(
                  widget.label,
                  style: TextStyle(color: Colors.white),
                )
        ],
      ),
    );
  }
}
