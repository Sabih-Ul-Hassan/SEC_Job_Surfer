/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 28,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contains a function, JS_AppBar, that returns a custom App Bar for the App
/// * Authorization : Everyone
/// * Coding Standards :
///     -- Class variables should start with a capital alphabet
///     -- Methods, functions, and local variables should be written
///        in cemal case
///     -- Functions that return a widget should start with an uppercase alphabet
///     -- Methods and functions should not hav more then 10 statements
///     -- Function or methods, that return a widget, should not be limited
///        in terms of number of lines
///     -- Global variables should end with _G

import 'package:flutter/material.dart';
import '../Variables.dart';

AppBar JS_AppBar() {
  return AppBar(
    title: Text(name_G),
    centerTitle: true,
  );
}
