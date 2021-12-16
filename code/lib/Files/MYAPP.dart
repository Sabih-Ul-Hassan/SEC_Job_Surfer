/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 28,2021
/// * Modification History :
///     -- Content of thi file was created on November 29,2021; but this file was created on December 1,2021
/// * Synopsis :
///     -- This File contains a stateless widget's sub class, MYAPP, that contains data, related to the app
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
import 'package:sec/Files/MYAPP.dart';
import 'package:flutter/material.dart';
import 'package:sec/Files/ViewApplications.dart';
import 'package:sec/Variables.dart';
import './LoginPage.dart';
import './EmployerLoggedInScreen.dart';
import './EmployerProfile.dart';
import './RespondToApplication.dart';
import './JobAds.dart';
import './SearchApplicant.dart';
import './JobAdsDetails.dart';
import './AddJobAd.dart';
import './EditJobAd.dart';
import './ApplicantProfileAltView.dart';
import './ViewApplications.dart';
import './Spinner.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ThemeData.dark().colorScheme.copyWith(
            primary: colorThird_G,
          )),
      initialRoute: "/LoginPage",
      routes: {
        "/LoginPage": (context) => LoginPage(),
        "/EmployerLoggedInScreen": (context) => EmployerLoggedInScreen(),
        "/EmployerProfile": (context) => EmployerProfile(),
        "/JobAds": (context) => JobAds(),
        "/JobAdsDetails": (context) => JobAdsDetails(),
        "/AddJobAd": (context) => AddJobAd(),
        "/EditJobAd": (context) => EditJobAd(),
        "/SearchApplicant": (context) => SearchApplicant(),
        "/ApplicantProfileAltView": (context) => ApplicantProfileAltView(),
        "/Spinner": (context) => Spinner(),
        "/ViewApplications": (context) => ViewApplications(),
        "/RespondToApplication": (context) => RespondToApplication(),
      },
    );
  }
}



