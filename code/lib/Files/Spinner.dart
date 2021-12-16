/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : December 1,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contains a stateless widget's sub class, Spinner, that acts as the
///       a loading Screen
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
import '../Variables.dart';

class Spinner extends StatelessWidget {
  const Spinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return spinner_G;
  }
}
