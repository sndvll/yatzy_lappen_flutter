import 'package:flutter/material.dart';

typedef void ButtonClickCallback();

class ButtonProps {
  bool isDisabled;
  ButtonClickCallback onPressed;
  ButtonProps({@required this.isDisabled, @required this.onPressed});
}

class CircularButton extends StatelessWidget {
  final ButtonClickCallback onPressed;
  final Color backgroundColor;
  final Color color;
  final IconData icon;
  final String text;
  final Color disabledColor;

  CircularButton.icon(
      {@required this.onPressed,
      @required this.icon,
      this.backgroundColor = Colors.blue,
      this.color = Colors.white,
      this.text = '',
      this.disabledColor = Colors.grey});
  CircularButton.text(
      {@required this.onPressed,
      @required this.text,
      this.backgroundColor = Colors.blue,
      this.color = Colors.white,
      this.icon,
      this.disabledColor = Colors.grey});

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onPressed,
      child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: this.icon != null
                  ? Icon(icon,
                      color: this.onPressed != null ? color : disabledColor)
                  : Text(text,
                      style: TextStyle(
                          color: this.onPressed != null
                              ? color
                              : disabledColor)))));
}
