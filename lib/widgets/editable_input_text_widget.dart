import 'package:flutter/material.dart';

class EditableInputText extends StatelessWidget {

  final TextInputType? inputType;
  final TextEditingController? controller;
  final maxLength;
  final maxLines;
  final bool? obscureText;
  final bool? textAlignRight;

  EditableInputText({Key? key,
                    @required this.inputType,
                    @required this.controller,
                    @required this.maxLength,
                    @required this.maxLines,
                    this.obscureText,
                    this.textAlignRight});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: (textAlignRight != null) ? TextAlign.right : TextAlign.left,
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: inputType,
      autofocus: false,
      obscureText: (obscureText != null) ? obscureText! : false,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(color: new Color(0xFF3E3E3E)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                  color: Theme.of(context).highlightColor, width: 1.0
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                  color: Theme.of(context).highlightColor, width: 1.0
              )
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: 10.00, horizontal: 10.00
          )
      ),
      buildCounter: (BuildContext context, { int? currentLength, int? maxLength, bool? isFocused }) => null,
    );
  }
}
