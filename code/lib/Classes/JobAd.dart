/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 29,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contain the definition of Job AD class
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
import 'package:collection/collection.dart';

class JobAd {
  late String _Title;
  late int _PostedBy;
  late String _Description;
  late String _ExpireDate;
  late String _PostedDate;
  late int _SalaryFrom;
  late int _SalaryTo;
  late int _JobID;
  late int _RequiredExperience;
  late List<String> _SkillsRequired;
  late List<String> _Responsiibilitie;

  String get Title => _Title;

  set Title(String value) {
    _Title = value;
  }

  //named, no argument, constructor
  JobAd.one();

  @override
  String toString() {
    return 'JobAd{_Title: $_Title,  _Description: $_Description, _ExpireDate: $_ExpireDate, _PostedDate: $_PostedDate, _SalaryFrom: $_SalaryFrom, _SalaryTo: $_SalaryTo, _JobID: $_JobID, _RequiredExperience: $_RequiredExperience, _SkillsRequired: $_SkillsRequired, _Responsiibilitie: $_Responsiibilitie}';
  }

  //constructor
  JobAd(
      this._Title,
      this._Description,
      this._ExpireDate,
      this._PostedDate,
      this._SalaryFrom,
      this._SalaryTo,
      this._JobID,
      this._RequiredExperience,
      this._SkillsRequired,
      this._Responsiibilitie,
      [this._PostedBy = 0]);

  void setTitle(String value) {
    _Title = value;
  }

  void setDescription(String value) {
    _Description = value;
  }

  void setResponsiibilitie(List<String> value) {
    _Responsiibilitie = value;
  }

  void setSkillsRequired(List<String> value) {
    _SkillsRequired = value;
  }

  void setRequiredExperience(int value) {
    _RequiredExperience = value;
  }

  void setJobID(int value) {
    _JobID = value;
  }

  void setSalaryTo(int value) {
    _SalaryTo = value;
  }

  void setSalaryFrom(int value) {
    _SalaryFrom = value;
  }

  void setPostedDate(String value) {
    _PostedDate = value;
  }

  void setExpireDate(String value) {
    _ExpireDate = value;
  }

  void setPostedBy(int cnic) {
    _PostedBy = cnic;
  }

  String get Description => _Description;

  int get PostedBy => _PostedBy;

  String get ExpireDate => _ExpireDate;

  String get PostedDate => _PostedDate;

  int get SalaryFrom => _SalaryFrom;

  int get SalaryTo => _SalaryTo;

  int get JobID => _JobID;

  int get RequiredExperience => _RequiredExperience;

  List<String> get SkillsRequired => _SkillsRequired;

  List<String> get Responsiibilitie => _Responsiibilitie;

  set PostedBy(int value) {
    _PostedBy = value;
  }

  set Responsiibilitie(List<String> value) {
    _Responsiibilitie = value;
  }

  set SkillsRequired(List<String> value) {
    _SkillsRequired = value;
  }

  set RequiredExperience(int value) {
    _RequiredExperience = value;
  }

  set JobID(int value) {
    _JobID = value;
  }

  set SalaryTo(int value) {
    _SalaryTo = value;
  }

  set SalaryFrom(int value) {
    _SalaryFrom = value;
  }

  set PostedDate(String value) {
    _PostedDate = value;
  }

  set ExpireDate(String value) {
    _ExpireDate = value;
  }

  set Description(String value) {
    _Description = value;
  }

// this method retrieves the skills, required for a job ad, from the database;
// and update the results in the object
  Future<void> getSkills(context) async {
    try {
      var r = await MySQL.query(
          "SELECT SkillName FROM sql4456852.JobAd_has_Skills natural join sql4456852.Skills where JobAdID = '$JobID';",context);
      SkillsRequired.clear();
      for (var row in r) SkillsRequired.add(row[0]);
    } on Exception catch (e) {
      print(e);
    }
  }

// this method retrieves the responsibilities, of a job, from the database;
// and update the results in the object
  Future<void> getResponsibilities(context) async {
    try {
      var r = await MySQL.query(
          "SELECT Responsibility FROM sql4456852.JobAd_has_Responsibility natural join sql4456852.Responsibility where JobAdID = '$JobID';",context);
      Responsiibilitie.clear();
      for (var row in r) Responsiibilitie.add(row[0]);
    } on Exception catch (e) {
      print(e);
    }
  }

  //this method allows the employer to add new skills,
  // required for a job add, in the database and the object
  Future<void> addSkills(List<String> skills,context) async {
    await MySQL.query(" DELETE FROM `sql4456852`.`JobAd_has_Skills` WHERE `JobAdID` = '${this.JobID}' ; ",context);
    for (String s in skills) {
      s = s.trim(); //remove the ending and stating spaces, to remove possible duplication in the database
      if (s.length > 0) { // if skill is null (empty), it wont be stored or added in the database
          try {
            await MySQL.queryDuplication("INSERT INTO `sql4456852`.`Skills` (`SkillName`) VALUES ('${s}'); ",context);

          } on Exception catch (e) {} // do nothing
          try {await MySQL.queryDuplication(
                "INSERT INTO `sql4456852`.`JobAd_has_Skills` (`JobAdID`, `SkillsID`) VALUES ('${this.JobID}',"
                "(select SkillsID from `sql4456852`.Skills where SkillName='$s'));",context);
          } on Exception catch (e) {} // do nothing
      }}
    await getSkills(context); // update the skills in the object
  }

  //this method allows the employer to add new skills,
  // required for a job add, in the database and the object
  Future<void> addResponsibilities(List<String> responsibilities,context) async {
      await MySQL.queryDuplication("DELETE FROM sql4456852.JobAd_has_Responsibility WHERE ( JobAdID =  $JobID );",context);
      for (String r in responsibilities) {
        r = r.trim();//remove the ending and stating spaces, to remove possible duplication in the database
        if (r.length > 0) {// if responsibility is null (empty), it wont be stored or added in the database
          try {
            await MySQL.queryDuplication("INSERT INTO `sql4456852`.`Responsibility` (`Responsibility`) VALUES ('${r}'); ",context);
          } on Exception catch (e) {} // do nothing
            try {
              await MySQL.query("INSERT INTO `sql4456852`.`JobAd_has_Responsibility` (`JobAdID`, `ResponsibilityID`) VALUES ('${this.JobID}',"
                  "(select ResponsibilityID from `sql4456852`.Responsibility where Responsibility='$r'));",context);
            } on Exception catch (e) {} //do nothing
}}
      await getResponsibilities(context); // update the responsibilities in the object
  }
}
