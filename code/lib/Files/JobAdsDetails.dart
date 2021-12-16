/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 29,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contains a stateful widget's sub class, JobAdsDetails, that acts as the
///       view job ad's detail Screen
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

import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../CustomWidgets/TwoValuesText.dart';
import '../Classes/JobAd.dart';
import '../Classes/Employer.dart';
import '../Variables.dart';

class _JobAdsDetailsState extends State<JobAdsDetails> {
  @override
  Widget build(BuildContext context) {
    Map m1 = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    JobAd ad = m1["ad"];
    Employer employer = m1["employer"];
    dynamic preSetState = m1["setState"];
    return Scaffold(
      appBar: JS_AppBar(),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Key1("Title", 17.0),
          LimitedBox(maxWidth: 200.0, child: Value(ad.Title, 15.0)),
          Key1("Description", 17.0),
          Value(ad.Description, 15.0),
          Key1("Expire Date", 17.0),
          ValueWithFormat(ad.ExpireDate, 15.0,200.0,15.0,"(yyyy-mm-dd)"),
          Key1("Posted Date", 17.0),
          ValueWithFormat(ad.PostedDate, 15.0,200.0,15.0,"(yyyy-mm-dd)"),
          Key1("Salary From", 17.0),
          Value(ad.SalaryFrom, 15.0),
          Key1("Salary To", 17.0),
          Value(ad.SalaryTo, 15.0),
          Key1("Required Experience in Years", 17.0),
          ValueWithFormat(ad.RequiredExperience, 15.0,200.0,15.0,"(years)"),
          Key1("Skills Required", 17.0),
          Value(
              ad.SkillsRequired.toString()
                  .substring(1, ad.SkillsRequired.toString().length - 1),
              15.0),
          Key1("Responsibilities", 17.0),
          Value(
              ad.Responsiibilitie.toString()
                  .substring(1, ad.Responsiibilitie.toString().length - 1),
              15.0),
        ],
      )),
      floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children:[
        FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/ViewApplications",arguments: {'employer':employer,"AdID":ad.JobID});
        },
        child: Icon(Icons.person),
        backgroundColor: colorThird_G,
      ),
        Padding(
          padding: const EdgeInsets.only(top:15,bottom: 5 ),
          child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/EditJobAd", arguments: {
              "ad": ad,
              "preSetState": preSetState,
              "setState": setState,
              "employer": employer
            });
          },
          child: Icon(Icons.edit),
          backgroundColor: colorThird_G,
      ),
        ),]),
    );
  }
}

class JobAdsDetails extends StatefulWidget {
  const JobAdsDetails({Key? key}) : super(key: key);

  @override
  _JobAdsDetailsState createState() => _JobAdsDetailsState();
}
