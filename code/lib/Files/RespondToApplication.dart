/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : December 15,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contain the definition of Respond To Application stateful widget
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
import 'package:sec/CustomWidgets/TwoValuesText.dart';
import 'package:sec/CustomWidgets/txtfeilds.dart';
import '../Variables.dart';
import 'package:sec/Classes/Application.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../Classes/Employer.dart';

class RespondToApplication extends StatefulWidget {
  const RespondToApplication({Key? key}) : super(key: key);

  @override
  _RespondToApplicationState createState() => _RespondToApplicationState();
}

class _RespondToApplicationState extends State<RespondToApplication> {

  TextEditingController note = TextEditingController();
  late int applicationID;
  late Employer employer;
  late Function preScreen;
  @override
  Widget build(BuildContext context) {

  applicationID=(ModalRoute.of(context)?.settings.arguments as Map)['applicationID'] ;
  employer=(ModalRoute.of(context)?.settings.arguments as Map)['employer'];
  preScreen=(ModalRoute.of(context)?.settings.arguments as Map)['preSetState'];

    return Scaffold(
      appBar: JS_AppBar(),
      body: SingleChildScrollView(child:Column(
        children: [
          Padding(padding: EdgeInsets.only(right:260,top:10,bottom: 15),
          child:Key1("Note", 17)),
          JsTextArea("Enter a note about the application, for example, we are gald that you should interest. but we are"
              " not looking for someone h your set of skills...  ", note, 15),
          Row(children: [
            Padding(
              padding: EdgeInsets.only(left:55,right:50),
              child:
                FlatButton.icon(
                  onPressed: ()async{
                    Navigator.pushNamed(context, "/Spinner");
                    if((await employer.respondToApplication(applicationID, "Accepted", note.text.trim().length>0?note.text.trim():"None", context)) is bool) return;
                    Navigator.pop(context);//removes spinner
                    Navigator.pop(context);//goes back to previous window
                    await preScreen();
                  },
                  label: Text("Accept"),
                  color: colorThird_G, icon: Icon(Icons.done),
                ),
            ),
            Padding(
              padding: EdgeInsets.only(),
              child:
                FlatButton.icon(
                  onPressed: ()async{
                    Navigator.pushNamed(context, "/Spinner");
                    if((await employer.respondToApplication(applicationID, "Rejected", note.text.trim().length>0?note.text.trim():"None", context)) is bool) return;
                    Navigator.pop(context);//removes spinner
                    Navigator.pop(context);//goes back to previous window
                    await preScreen();
                  },
                  label: Text("Reject"),
                  color: colorThird_G, icon: Icon(Icons.close),
                ),
            ),
          ],)
        ],
      )),
    );
  }
}
