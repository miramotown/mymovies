import 'package:flutter/material.dart';

class UneditableInputText extends StatelessWidget {

  final String? inputText;
  final bool? centerText;
  final bool? enabled;
  int? maxLines = 1;

  UneditableInputText({Key? key, @required this.inputText, this.centerText, this.enabled, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(inputText!),
      initialValue: inputText,
      readOnly: true,
      autofocus: false,
      enableInteractiveSelection: false,
      decoration: new InputDecoration(
          filled: true,
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
      textAlign: (centerText != null) ? TextAlign.center : TextAlign.start,
      enabled: (enabled != null) ? (enabled) : true,
      maxLines: maxLines,
    );
  }

}

