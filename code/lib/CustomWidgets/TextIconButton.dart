/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 29,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contains a function, TexTIconButton, that returns a custom Icon Button
/// * Authorization : Everyone
/// * Coding Standards :
///     -- Class variables should start with a capital alphabet
///     -- Methods, functions, and local variables should be written
///        in cemal case
///     -- Functions that return a widget should start with an uppercase alphabet
///     -- Methods and functions should not hav more then 10 statements
///     -- Function or methods, that return a widget, should not be limited
///        in terms of number of lines, and start with a upper case aplhabet
///     -- Global variables should end with _G
import 'package:flutter/material.dart';

Column TextIconButtom(function, icon, iconSize, color, text) {
  return Column(
    children: [
      IconButton(
        onPressed: function,
        icon: Icon(icon),
        iconSize: iconSize,
        color: color,
      ),
      Center(child: Text(text))
    ],
  );
}
