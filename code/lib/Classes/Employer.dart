/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 28,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contain the definition of Employer class
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

import 'package:mysql1/mysql1.dart';
import 'package:sec/Classes/Applicant.dart';
import 'package:sec/Classes/Application.dart';
import 'User.dart';
import 'MySQL.dart';
import 'JobAd.dart';

class Employer extends User{

  late String _CompanyName;
  late List<JobAd> JobAds=[];
  static bool LoggedIn= false;


  Employer();


  //this method searches the given credentials, of th employer, in the database, if employer authenticates, it
  //stores it in the objects and return true; else it return false
  Future<bool> login(String username, password,context) async {
    if(!await super.login(username,password,context)) return false; //login failed
    Results results = await MySQL.query("select * from Employer where CNIC = $CNIC",context);
    if(results.isEmpty) return false; //login failed
    for(var row in results)
          _CompanyName=row[1];
      return LoggedIn=true; // sets LoggedIn to true, and return true
  }


  Future<dynamic> deleteJobAd(JobID,context) async{
    if (await MySQL.query("DELETE FROM `sql4456852`.`JobAd` WHERE (`JobAdID` = '$JobID');",context,removePreContext: false) is bool)
      return false; // if no internet connection, else return void
  }

  // it returns all the ads, posted by this employeer, after retiring them from the database
  Future<dynamic> viewJobAds(context) async {
      JobAds.clear(); // removes all the adds from the list, because it is possible that if we don't
      // clear it, it might retain deleted or un-updated ads
      dynamic results = await MySQL.query("SELECT * FROM sql4456852.JobAd where CNIC=$CNIC;",context);
      if( results is bool) return;//no internet
        for(var row in results){
          JobAd j1 = JobAd(row[8], row[1], row[2], row[3], row[4], row[5], row[0], row[6], [], [],row[7]);
          await j1.getSkills(context);
          await j1.getResponsibilities(context);
          JobAds.add(j1);
        }
        return JobAds;
  }
  Employer.one(int CNIC, String Name, String UserName, String Address, String DateOfBirth, String ContactNumber, this._CompanyName) : super.one(CNIC, Name, UserName, Address, DateOfBirth, ContactNumber);

  @override
  String toString() {
    return 'Employer{_CompanyName: $_CompanyName}'+super.toString();
  }

  String get CompanyName => _CompanyName;

  void setCompanyName(String value) {
    _CompanyName = value;
  }

  Future<void> addJobAd(JobAd jobAd,context) async {
    if(await MySQL.query("INSERT INTO `sql4456852`.`JobAd` (`Description`, "+
        "`ExpireDate`, `PostedDate`, `SalaryFrom`, `SalaryTo`, `RequiredExperience`, `CNIC`, "+
        "`Title`) VALUES ('${jobAd.Description}', '${jobAd.ExpireDate}', '${jobAd.PostedDate}', ${jobAd.SalaryFrom},"
        +" ${jobAd.SalaryTo}, ${jobAd.RequiredExperience}, ${CNIC}, '${jobAd.Title}');",context) is bool)
      return; // if no internet connection, the rest queries won't be forward to the database
    var r = await MySQL.query("Select Max(JobAdId) from `sql4456852`.`JobAd` ;",context); // retrieving the
    // auto generated id of the last added ad
    for(var row in r ) jobAd.JobID= row[0]; // storing the retrieved id in the object
    await jobAd.addSkills(jobAd.SkillsRequired,context); // add skills against the ad
    await jobAd.addResponsibilities(jobAd.Responsiibilitie,context); // adding responsibilities against the add
  }

  Future<dynamic> editJobAd(JobAd ad,context) async {
    try { // if there is internet connection
      print("done1");
      if ((await MySQL.query("UPDATE `sql4456852`.`JobAd` SET `Description` = '${ad.Description}', "
          "`ExpireDate` = '${ad.ExpireDate}', `SalaryFrom` = '${ad.SalaryFrom}', `SalaryTo` = '${ad.SalaryTo}',"
          " `RequiredExperience` = '${ad.RequiredExperience}', `Title` = '${ad.Title}'"
          " WHERE (`JobAdID` = '${ad.JobID}');",context,callingEditADD: true)) is bool) return false; // no internet connection, so rest won't be executes
      print("done2");
      // this function will first  remove all the
      // responsibilities, and then update them
       await ad.addResponsibilities(ad.Responsiibilitie,context);
      // this function will first  remove all the
      // skills, and then update them
        await ad.addSkills(ad.SkillsRequired,context);
        return true; // executed successfully
    } on Exception catch (e) {} // do nothing
}

  Future<List<Applicant>> searchApplicants(List<String> paras,context) async{
    Set<int> applicants = Set();
    Map<dynamic,dynamic> applicantObjects = Map();
    applicantObjects.addAll({"initialized": false});
    List<dynamic> result = await iterateParams(applicants,applicantObjects,paras,context); //filters the applicants, based on paras (parameters); stores the filtered applicant's
    applicants=result[0];
    applicantObjects=result[1];
    // CNICs into the set (Applicant),and the objects in the Map (applicantObjects )
    return applicants_MapToList(applicants,applicantObjects); //retrives the filtered applicants objects,
    // based on their CNICs, and returns the list of Applicant
  }

  //this method takes the reference of a set (applicants), a map (applicantObjects), and parameters, searches
  // parameters, one by on, in the database; store all the objects in the map (applicantObjects), stored the applicantObjects (CNIC)
  // of filtered applicants into set (applicants), and returns the applicants and applicantObjects as a list
  Future<List<dynamic>> iterateParams(applicants,applicantObjects,paras,context)async{
    for(var para in paras){
      para=para.trim(); // removing the starting and ending spaces, as spaces can cause anomalies
      // in the  search, since two same string won't be equal if one has an extra starting or ending space
      if(para.length>0){ // if the parameter is not null,
        Set<int> parameterResult = Set();
        await updateSearch(parameterResult, applicantObjects,para,context);
        if(!applicantObjects["initialized"]) {
          applicantObjects["initialized"]=true; // for the first search parameter, we will store the resultant applicant its
          // in the applicants list, after the first parameter, we will intersect the result of the current
          // parameter from the results of the last parameters(Applicant list), in order to
          // filter applicants, based on the parameters
          applicants = applicants.union(parameterResult);
        } else applicants = applicants.intersection(parameterResult);}}
    return [applicants,applicantObjects];
}

  //This method takes a single para (parameter), search the applicants based on that parameter,
  // stores the object in applicantObjects (map), and CNICs in the parameterResult
  Future<void> updateSearch(parameterResult, applicantObjects,para,context)async {
    var rows = await MySQL.query(
        "select * from sql4456852.Profile where cnic  = any (SELECT CNIC FROM "
            "sql4456852.Applicant natural join sql4456852.Profile where username Like '%$para%' union SELECT CNIC"
            " FROM sql4456852.Applicant natural join sql4456852.Profile where name Like '%$para%' union SELECT"
            " CNIC FROM sql4456852.Applicant_has_Skills natural join sql4456852.Skills where skillName Like '%$para%' )",context);
    for (var row in rows) {
      Applicant a1 = Applicant.one(row[0], row[1], row[2], row[5], row[4], row[6]);
      await a1.getSkills(context);
      applicantObjects.addAll({row[0]: a1});
      parameterResult.add(row[0]);}}

  // This method takes an set (applicants),containing CNICs of applicants, and using those sets, selects filtered applicants form the applicantObjects map
  List<Applicant> applicants_MapToList(applicants,applicantObjects){
    List<Applicant> list = [];
    applicantObjects.forEach((key, value) {
      if(applicants.contains(key)) list.add(value);} );
    return list;
  }

  Future<dynamic> viewApplicant(CNIC,context) async {
    var results = await MySQL.query(
        "SELECT * FROM sql4456852.Profile natural join sql4456852.Applicant where CNIC = '$CNIC'",
        context);
    if (results is bool) return false;
    Applicant applicant = Applicant.one(
        results.first[0], results.first[1], results.first[2], results.first[5],
        results.first[4], results.first[6]);
    await applicant.getSkills(context);
    return applicant;
  }

  Future<dynamic> viewApplications(adID,context,responded)async{
    var results;
    if(responded) results =await MySQL.query("select * from `sql4456852`.`Application` natural join  `sql4456852`.`Profile` where JobAdID='$adID' and Status <> 'Not Responded';",context,removePreContext: false);
    else  results =await MySQL.query("select * from `sql4456852`.`Application` natural join  `sql4456852`.`Profile` where JobAdID='$adID' and Status = 'Not Responded';",context,removePreContext: false);
    if(results is bool) return;//no internet
    List<Application> applications=[];
    for(var row in results) applications.add(Application(row[1], row[5], row[2], row[3], row[0], row[4]));
    return applications;
  }

  Future<dynamic> respondToApplication(ApplicationID,status,note,context)async{
    var results =await MySQL.query("UPDATE `sql4456852`.`Application` SET `EmployerNote` = '$note', `Status` = '$status' WHERE (`ApplicationID` = '$ApplicationID');",context);
    if(results is bool) return results; //no internet
    List<Application> applications=[];
    for(var row in results) applications.add(Application(row[1], row[5], row[2], row[3], row[0], row[4]));
    return applications;

  }
 }
