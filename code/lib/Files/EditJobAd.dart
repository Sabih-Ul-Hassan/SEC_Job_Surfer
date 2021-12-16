/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 30,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contains a stateful widget's sub class, EditJobAd, that acts as the
///        Edit Job Screen
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
import 'package:sec/Classes/JobAd.dart';
import 'package:sec/Classes/Employer.dart';
import '../CustomWidgets/TwoValuesText.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../CustomWidgets/txtfeilds.dart';
import '../Variables.dart';

class EditJobAd extends StatefulWidget {
  const EditJobAd({Key? key}) : super(key: key);

  @override
  _EditJobAdState createState() => _EditJobAdState();
}

class _EditJobAdState extends State<EditJobAd> {
  late DateTime _Date;
  TextEditingController SalaryFrom = TextEditingController();
  TextEditingController SalaryTo = TextEditingController();
  TextEditingController Title = TextEditingController();
  TextEditingController Description = TextEditingController();
  TextEditingController Experience = TextEditingController();
  TextEditingController SkillsRequired = TextEditingController();
  TextEditingController Responsibilities = TextEditingController();
  late Employer employer;
  bool Initilized = false;

  void loadDate(ad) {
    if (!Initilized)
      _Date = DateTime(
          int.parse(ad.ExpireDate.substring(0, 4)),
          int.parse(ad.ExpireDate.substring(5, 7)),
          int.parse(ad.ExpireDate.substring(8, 10)));
    preSetState = m1["setState"];
    prePreSetState = m1["preSetState"];
    Initilized = true;
  }
  late JobAd ad;
  late Map m1;
  dynamic preSetState ;
  dynamic prePreSetState;
  @override
  Widget build(BuildContext context) {
     m1 =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    if(!Initilized){ // initialize the data , only when the function is ran  for the first time, when date is
      // changes on the second time, data wont be reset
       ad = m1["ad"];
      employer = m1["employer"];

      SalaryFrom.text = ad.SalaryFrom.toString();
      SalaryTo.text = ad.SalaryTo.toString();
      Title.text = ad.Title;
      Description.text = ad.Description;
      Experience.text = ad.RequiredExperience.toString();
      SkillsRequired.text = ad.SkillsRequired.toString()
          .substring(1, ad.SkillsRequired.toString().length - 1);
      Responsibilities.text = ad.Responsiibilitie.toString()
          .substring(1, (ad.Responsiibilitie.toString().length) - 1);
    }
    loadDate(ad);
    return Scaffold(
      appBar: JS_AppBar(),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Key1("Title *", 17.0),
          JsTextFeild("For Example Job for a junior developer", Title,maxChars: 250),
          Key1("Description *", 17.0),
          JsTextArea(
              "Description, For Example Description for the post goes in here like this",
              Description,
              5,maxChars: 1000 ),
          Key1("Expire Date *", 17.0),
          Row(children: [
            ValueWithFormat(_Date.toString().substring(0, 10), 17,200.0,15.0,"(yyyy-mm-dd)",45.0),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: FlatButton(
                onPressed: () async {
                  var datePicker = await showDatePicker(
                      builder: (context, child) {
                        return Theme(
                            data: ThemeData.dark().copyWith(
                                colorScheme:
                                    ColorScheme.dark(primary: colorThird_G)),
                            child: child!);
                      },
                      context: context,
                      initialDate: _Date,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 100));
                  if (datePicker == null) return;
                  setState(() {
                    _Date = datePicker;
                  });
                },
                child: Text("Change", style: TextStyle(fontSize: 17.0)),
                color: colorThird_G,
              ),
            ),
          ]),
          Key1("Salary From *", 17.0),
          JsTextFeildNumbers(
            "Salary, For Example 20000",
            SalaryFrom,
          ),
          Key1("Salary To *", 17.0),
          JsTextFeildNumbers("Salary, For Example 20000", SalaryTo),
          Key1("Required Experience in Years *", 17.0),
          JsTextFeildNumbers("Experience in years, For Example 3", Experience),
          Key1("Skills Required", 17.0),
          JsTextArea(
              " for example css, web development, html", SkillsRequired, 5,
              helperText: "Enter skills requires, seperated by commas"),
          Key1("Responsibilities", 17.0),
          JsTextArea(
              " for example junior developer, tester", Responsibilities, 5,
              helperText: "Enter Responsibilities, seperated by commas"),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: FlatButton(
              onPressed: () async {
                var loading = false;
                try {
                  if (Title.text.length < 1 ||
                      Description.text.length < 1 ||
                      SalaryFrom.text.length < 1 ||
                      SalaryTo.text.length < 1 ||
                      Experience.text.length < 1) throw Exception("");
                  ad.Title = Title.text;
                  ad.Description = Description.text;
                  ad.ExpireDate = _Date.toString().substring(0, 10);
                  ad.SalaryFrom = int.parse(SalaryFrom.text);
                  ad.SalaryTo = int.parse(SalaryTo.text);
                  ad.RequiredExperience = int.parse(Experience.text);
                  ad.SkillsRequired = SkillsRequired.text.split(',');
                  ad.Responsiibilitie = Responsibilities.text.split(',');
                  Navigator.pushNamed(context, "/Spinner");
                  loading = true;
                  try {

                    if( await employer.editJobAd(ad,context)) {
                      preSetState(() {});
                    await prePreSetState();
                    Navigator.pop(context);
                    Navigator.pop(context);}
                    } on Exception {
                    Navigator.pop(context);
                  }

                } catch (e) {
                  print(e);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Invalid Entry"),
                            content: Text(
                                "Please make sure all of your entries are correct."),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    if (loading) Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Okay."))
                            ],
                          ));
                }
              },
              child: Text("Save", style: TextStyle(fontSize: 17.0)),
              color: colorThird_G,
            ),
          )
        ],
      )),
    );
  }
}
