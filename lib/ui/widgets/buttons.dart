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
  final Color iconColor;
  final Icon icon;

  CircularButton(
      {@required this.onPressed,
      @required this.icon,
      this.backgroundColor = Colors.blue,
      this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(50)),
      child: IconButton(icon: icon, color: iconColor, onPressed: onPressed),
    );
  }
}
