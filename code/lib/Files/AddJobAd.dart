/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 30,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contains a stateful widget, AddJobAd, that acts as the add job ad screen
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

class AddJobAd extends StatefulWidget {
  const AddJobAd({Key? key}) : super(key: key);

  @override
  _AddJobAdState createState() => _AddJobAdState();
}

class _AddJobAdState extends State<AddJobAd> {
  DateTime? _Date;
  TextEditingController SalaryFrom = TextEditingController();
  TextEditingController SalaryTo = TextEditingController();
  TextEditingController Title = TextEditingController();
  TextEditingController Description = TextEditingController();
  TextEditingController Experience = TextEditingController();
  TextEditingController SkillsRequired = TextEditingController();
  TextEditingController Responsibilities = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map? m1 =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Employer employer = m1["employer"];
    dynamic refreshPreviousPadeFunction = m1["refreshPreviousPadeFunction"];
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
              5,maxChars: 1000),
          Key1("Expire Date *", 17.0),
          Row(children: [
            _Date==null?Value( "yyyy-mm-dd",17):ValueWithFormat(_Date.toString().substring(0,10), 17,200.0,15.0,"(yyyy-mm-dd)",40.0),
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
                      initialDate: _Date == null ? DateTime.now() : _Date!,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 100));
                  if (datePicker == null) return;
                  print(datePicker);
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
          JsTextFeildNumbers("Salary, For Example 20000", SalaryFrom),
          Key1("Salary To *", 17.0),
          JsTextFeildNumbers("Salary, For Example 20000", SalaryTo),
          Key1("Required Experience in Years *", 17.0),
          JsTextFeildNumbers("Experience in years, For Example 3", Experience),
          Key1("Skills Required", 17.0),
          JsTextArea(
              "Enter skills requires, seperated by commas; for example css, web development, html",
              SkillsRequired,
              5,
              helperText: "Enter skills requires, seperated by commas"),
          Key1("Responsibilities", 17.0),
          JsTextArea(
              "Enter Responsibilities, seperated by commas; for example junior developer, tester",
              Responsibilities,
              5,
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
                  Navigator.pushNamed(context, "/Spinner");
                  loading = true;
                  try {
                    await employer.addJobAd(JobAd(
                                          Title.text,
                                          Description.text,
                                          _Date.toString().substring(0, 10),
                                          DateTime.now().toString().substring(0, 10),
                                          int.parse(SalaryFrom.text),
                                          int.parse(SalaryTo.text),
                                          1,
                                          int.parse(Experience.text),
                                          SkillsRequired.text.split(','),
                                          Responsibilities.text.split(',')),context);
                    await refreshPreviousPadeFunction();
                    Navigator.popUntil(context, ModalRoute.withName("/JobAds"));
                  }
                  catch (e) { Navigator.pop(context);
                  }
               }
                catch (e) {
                  print(e);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Invalid Entry"),
                            content: Text(
                                "There was some error, please make sure all of your entries are correct amd complete."),
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
