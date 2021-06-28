import 'package:flutter/material.dart';
import 'package:lifeline/constants.dart';

class InputText extends StatefulWidget {
  Function ontap;
  String hintText;
  String labelText;
  Icon prefixIcon;

  InputText({this.ontap, this.hintText, this.labelText, this.prefixIcon});

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
        onChanged: widget.ontap,
        decoration: kTextFieldDecoration.copyWith(
          hintText: widget.hintText,
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
        ),
      ),
    );
  }
}
