/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 29,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contains a function, JobOverView, that returns a custom Widget
///        for displaying overview of a job ad
/// * Authorization : Everyone
/// * Coding Standards :
///     -- Class variables should start with a capital alphabet
///     -- Methods, functions, and local variables should be written
///        in cemal case
///     -- Functions that return a widget should start with an uppercase alphabet
///     -- Methods and functions should not hav more then 10 statements
///     -- Function or methods, that return a widget, should not be limited
///        in terms of number of lines, and start with a upper case aplhabet
///     -- Global variables should end with _G

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sec/Classes/JobAd.dart';
import 'package:sec/CustomWidgets/TwoValuesText.dart';
import 'package:sec/Variables.dart';

dynamic JobOverview(JobAd j, employer, refreshScreen, context, setState,ads,changeLoaded) {
  return Container(
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/JobAdsDetails',
                            arguments: {
                              "ad": j,
                              "setState": refreshScreen,
                              "employer": employer
                            });
                      },
                      child: Text("Details"),
                      color: colorThird_G,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => (AlertDialog(
                                  title: Text("Conformation"),
                                  content: Text(
                                      "Are you sure you want to remove " +
                                          j.Title +
                                          "?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          try {

                                            Navigator.pop(context);
                                            setState((){changeLoaded();});
                                           if ( await employer.deleteJobAd(j.JobID,context) is bool) {
                                             //rNavigator.pushNamed(context, "/JobAds");
                                             }// do nothing
                                          else {

                                             employer.JobAds.clear();
                                             dynamic ads1 = (await employer.viewJobAds(context)).reversed.toList();
                                             ads.clear();

                                             for(var ad in ads1) ads.add(ad);
                                          }
                                             setState((){changeLoaded();});
                                          } on Exception catch (e) {
                                            print(e); // TODO
                                          }
                                        },
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(color: colorThird_G),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "No",
                                          style: TextStyle(color: colorThird_G),
                                        ))
                                  ])));
                    },
                    child: Text("Remove"),
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
                        "Job Title  : ",
                        style: TextStyle(fontSize: 17, color: colorThird_G),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: LimitedBox(
                          maxWidth: 200.0,
                          child: Text(
                            j.Title,
                            style: TextStyle(fontSize: 15.0),
                            textAlign: TextAlign.left,
                          )),
                    ),
                    Text(
                      "Posted on  : ",
                      style: TextStyle(fontSize: 17, color: colorThird_G),
                    ),
                    ValueWithFormat(j.PostedDate,15.0,200.0,0.0,"(yyyy-mm-dd)",30.0),
                    Text(
                      "Valid Till : ",
                      style: TextStyle(fontSize: 17, color: colorThird_G),
                    ),
                    ValueWithFormat(j.ExpireDate,15.0,200.0,0.0,"(yyyy-mm-dd)",30.0),
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
}
