/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : December 1,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contains a stateful widget's sub class, SearchApplicant, that acts as the
///       Search Applicant Screen
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
import 'package:sec/Classes/Applicant.dart';
import 'package:sec/Classes/Employer.dart';
import 'package:sec/CustomWidgets/txtfeilds.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../CustomWidgets/TwoValuesText.dart';
import '../Variables.dart';

class SearchApplicant extends StatefulWidget {
  const SearchApplicant({Key? key}) : super(key: key);

  @override
  _SearchApplicantState createState() => _SearchApplicantState();
}

class _SearchApplicantState extends State<SearchApplicant> {
  late Employer employer;

  List<Applicant> Applicants = [];
  var Loaded = true;
  TextEditingController Search = TextEditingController();
  String SearchResult = "Waiting for you to Search...";

  Future<void> SearchApplicants() async {
    setState(() {
      Loaded = false;
    });
    Applicants = await employer.searchApplicants(Search.text.split(','),context);
    if (Applicants.length < 1) SearchResult = "No user found";
    setState(() {
      Loaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map m1 =
        ModalRoute.of(context)?.settings.arguments as Map<String, Employer>;
    employer = m1["employer"];
    if (!Loaded)
      return spinner_G;
    else if (Applicants.length < 1)
      return Scaffold(
        appBar: JS_AppBar(),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    SizedBox(
                        width: 290,
                        child: JsTextFeildIconed(
                            " i.e. html, css, CNN, Paul ",
                            Search,
                            Icon(Icons.search, color: colorThird_G),
                            0.0,
                            0.0,
                            0.0,
                            20.0,
                            "Enter Usernames, name, Tags or skills (comma\n separated)")),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: FlatButton(
                        onPressed: () {
                          SearchApplicants();
                        },
                        child: Icon(Icons.search),
                        color: colorThird_G,
                      ),
                )
              ]),
            ),
            Center(child: Text(SearchResult))
          ],
        )),
      );
    else
      return Scaffold(
        appBar: JS_AppBar(),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                    width: 290,
                    child: JsTextFeildIconed(
                        " i.e. html, css, CNN, Paul ",
                        Search,
                        Icon(Icons.search, color: colorThird_G),
                        0.0,
                        0.0,
                        0.0,
                        20.0,
                        "Enter Usernames, name, Tags or skills (comma\n separated)")),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: FlatButton(
                    onPressed: () {
                      SearchApplicants();
                    },
                    child: Icon(Icons.search),
                    color: colorThird_G,
                  ),
                )
              ]),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: Applicants
                    .map((applicant) => Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.grey),
                            ),
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 7),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/dummyPFP.png'),
                                        radius: 50.0,
                                      ),
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                "/ApplicantProfileAltView",
                                                arguments: {
                                                  "applicant": applicant
                                                });
                                          },
                                          child: Text("view Profile"),
                                          color: colorThird_G)
                                    ]),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Key1("User Name", 17, 0.0),
                                    Value(applicant.userName, 15, 250.0, 0.0),
                                    Key1("Name", 17, 0.0),
                                    Value(applicant.Name, 15, 250.0, 0.0),
                                    Key1("Skills", 17, 0.0),
                                    Value(
                                        applicant.Skills.toString().substring(
                                            1,
                                            applicant.Skills.toString().length -
                                                1),
                                        15,
                                        200.0,
                                        0.0),
                                  ],
                                )
                              ]),
                            ))))
                    .toList())
          ],
        )),
      );
  }
}
