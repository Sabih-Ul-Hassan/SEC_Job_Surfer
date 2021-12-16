/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : December 15,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contain the definition of View Applications stateful functions that that an application, and return it in form of a widget
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
import 'package:sec/Classes/Application.dart';
import 'package:sec/Classes/Employer.dart';
import '../CustomWidgets/TwoValuesText.dart';

Container ApplicationOverview(context,Application application,Employer employer,setState,load) =>
    Container(
      child: (Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FlatButton(
                        onPressed: ()async {
                          Navigator.pushNamed(context, "/RespondToApplication",arguments: {"applicationID":application.ApplicationID,'employer':employer,'preSetState':load});
                        },
                        child: Text("Respond"),
                        color: colorThird_G,
                      ),
                    ),
                    FlatButton(
                      onPressed: ()async{

                        Navigator.pushNamed(context, "/Spinner" );
                        var applicant = await employer.viewApplicant(application.CNIC, context);
                        if( applicant is bool) return; // no internet
                        Navigator.pop(context);//remove spinner
                        Navigator.pushNamed(context, "/ApplicantProfileAltView" , arguments: {'applicant':applicant});
                      },
                      child: Text("Profile"),
                      color: colorThird_G,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          "Application By : ",
                          style: TextStyle(fontSize: 17, color: colorThird_G),
                        ),
                      ),
                      LimitedBox(
                          maxWidth: 200.0,
                          child: ValueWithFormat(
                            application.ApplicantName, 15.0, 200.0, 0.0,)),
                      Text(
                        "Status  : ",
                        style: TextStyle(fontSize: 17, color: colorThird_G),
                      ),
                      ValueWithFormat(application.Status, 15.0, 200.0, 0.0,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),
      ),
      margin: EdgeInsets.fromLTRB(5, 5, 5, 7),
    );

Container RespondedApplicationOverview(Application application) =>
    Container(
      child: (Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child:
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Application By : ",
                      style: TextStyle(fontSize: 17, color: colorThird_G),
                    ),
                  ),
                  LimitedBox(
                      maxWidth: 200.0,
                      child: ValueWithFormat(
                        application.ApplicantName, 15.0, 200.0, 0.0,)),
                  Text(
                    "Status  : ",
                    style: TextStyle(fontSize: 17, color: colorThird_G),
                  ),
                  ValueWithFormat(application.Status, 15.0, 200.0, 0.0,),
                  Text(
                    "Employer's Note  : ",
                    style: TextStyle(fontSize: 17, color: colorThird_G),
                  ),
                  Value(application.EmplyerNote, 15)
                ],
              ),
            ),
          ),
        ],
      )),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.grey),
      ),
      margin: EdgeInsets.fromLTRB(5, 5, 5, 7),
    );


