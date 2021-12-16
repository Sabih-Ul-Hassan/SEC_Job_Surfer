/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 30,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contains a functions, JsTextFeild, JsTextFeildIconed, JsTextFeildNumbers
///        and  JsTextArea, that returns a custom Text Feild Widgets
/// * Authorization : Everyone
/// * Coding Standards :
///     -- Class variables should start with a capital alphabet
///     -- Methods, functions, and local variables should be written
///        in cemal case
///     -- Functions that return a widget should start with an uppercase alphabet
///     -- Methods and functions should not hav more then 10 statements
///     -- Function or methods, that return a widget, should not be limited
///        in terms of number of lines, and start with a upper case alphabet
///     -- Global variables should end with _G
import 'package:flutter/material.dart';
import 'package:sec/Variables.dart';

Padding JsTextFeild(textHolder, controller, {helperText = "",maxChars=null}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
    child: TextField(
        cursorColor: colorThird_G,maxLength: maxChars,
        decoration: InputDecoration(
            hintText: textHolder,
            helperText: helperText,
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: colorThird_G)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: colorThird_G))),
        controller: controller),
  );
}

Padding JsTextFeildIconed(textHolder, controller, Icon icon,
    [padLeft = 20,
    padRight = 10,
    padTop = 10,
    padBottom = 0,
    description = "",
    obsecure = false,maxLen=null]) {
  return Padding(
    padding: EdgeInsets.fromLTRB(padLeft, padRight, padTop, padBottom),
    child: TextField(
        cursorColor: colorThird_G,
        obscureText: obsecure,
        maxLength:maxLen,
        decoration: InputDecoration(
            hintText: textHolder,
            helperText: description,
            prefixIcon: icon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorThird_G),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: colorThird_G),
            )),
        controller: controller),
  );
}

Padding JsTextFeildNumbers(textHolder, controller) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
    child: TextField(
      cursorColor: colorThird_G,
      decoration: InputDecoration(
          hintText: textHolder,
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: colorThird_G)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: colorThird_G))),
      controller: controller,
      keyboardType: TextInputType.number,
    ),
  );
}

Padding JsTextArea(textHolder, controller, lines, {helperText = "",maxChars=null}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
    child: TextField(
      cursorColor: colorThird_G,maxLength: maxChars,
      decoration: InputDecoration(
          hintText: textHolder,
          helperText: helperText,
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: colorThird_G)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: colorThird_G))),
      controller: controller,
      maxLines: lines,
    ),
  );
}
