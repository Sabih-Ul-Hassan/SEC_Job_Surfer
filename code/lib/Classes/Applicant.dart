/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : December 1,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contain the definition of Applicant class
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

import 'package:sec/Classes/MySQL.dart';
import "User.dart";

class Applicant extends User {
  List<String> _ExperienceOfFeild = [];
  List<String> _ExperienceInFeild = [];
  List<String> _Skills = [];

  Applicant.one(int CNIC, String Name, String UserName, String Address,
      String DateOfBirth, String ContactNumber)
      : super.one(CNIC, Name, UserName, Address, DateOfBirth, ContactNumber);

  Applicant() : super();

  List<String> get ExperienceOfFeild => _ExperienceOfFeild;

  List<String> get Skills => _Skills;

  set Skills(List<String> value) {
    _Skills = value;
  }

  set ExperienceOfFeild(List<String> value) {
    _ExperienceOfFeild = value;
  }

  List<String> get ExperienceInFeild => _ExperienceInFeild;

  set ExperienceInFeild(List<String> value) {
    _ExperienceInFeild = value;
  }
  // This method retrieves the skills, of the applicant has, from the database;
  // and stored them in the object
  Future<void> getSkills(context) async {
    if (Skills.length > 0) Skills.clear();
    var rows = await MySQL.query(
        "Select SkillName from `sql4456852`.`Applicant_has_Skills` natural join Skills where cnic = $CNIC;",context);
    for (var row in rows) Skills.add(row[0]);
  }
}
