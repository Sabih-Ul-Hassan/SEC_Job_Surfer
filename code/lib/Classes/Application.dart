/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : December 14,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contain the definition of Application class
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
class Application{

  late int _ApplicationID;
  late String _EmplyerNote;
  late String _Status ;
  late int _CNIC;
  late String _ApplicantName;
  late int _JobID;

  String get ApplicantName => _ApplicantName;

  set ApplicantName(String value) {
    _ApplicantName = value;
  }

  int get ApplicationID => _ApplicationID;

  set ApplicationID(int value) {
    _ApplicationID = value;
  }

  String get EmplyerNote => _EmplyerNote;

  int get JobID => _JobID;

  set JobID(int value) {
    _JobID = value;
  }

  int get CNIC => _CNIC;

  set CNIC(int value) {
    _CNIC = value;
  }

  String get Status => _Status;

  set Status(String value) {
    _Status = value;
  }

  set EmplyerNote(String value) {
    _EmplyerNote = value;
  }
  Application.one();

  Application(this._ApplicationID, this._ApplicantName,this._EmplyerNote, this._Status, this._CNIC,
      this._JobID);
}