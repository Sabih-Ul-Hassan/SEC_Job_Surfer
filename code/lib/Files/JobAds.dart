/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 29,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contains a stateful widget's sub class, JobAds, that acts as the
///       Overview job ads Screen
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../Variables.dart';
import '../CustomWidgets/JobOverview.dart';
import '../Classes/JobAd.dart';
import '../Classes/Employer.dart';

class JobAds extends StatefulWidget {
  const JobAds({Key? key}) : super(key: key);

  @override
  _JobAdsState createState() => _JobAdsState();
}

class _JobAdsState extends State<JobAds> {
  // this method loads ads from the database
  Future<void> loadAds() async {
    Loaded = false;
    ads.clear();
    setState(() {});
    Map m1 = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    employer = m1["employer"];
    employer.JobAds.clear();
    ads = (await employer.viewJobAds(context)).reversed.toList();
    setState(() {
      Loaded = true;
    });
  }

  void changeLoaded(){
    Loaded=!Loaded;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  late Employer employer;
  late List<JobAd> ads = [];
  bool Loaded = false;
  bool Initilized = false;

  @override
  Widget build(BuildContext context) {
    if (!Loaded) {
      if (!Initilized) {
        loadAds();
        Initilized = true;
      }
      return spinner_G;
    } else
      return Scaffold(
        appBar: JS_AppBar(),
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: ads.length,
            itemBuilder: (context, index) {
              return JobOverview(ads[index], employer, loadAds, context,setState,ads,changeLoaded);
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/AddJobAd", arguments: {
              "refreshPreviousPadeFunction": loadAds,
              "employer": employer
            });
          },
          child: Icon(
            Icons.add,
            size: 40,
          ),
          backgroundColor: colorThird_G,
        ),
      );
  }
}
