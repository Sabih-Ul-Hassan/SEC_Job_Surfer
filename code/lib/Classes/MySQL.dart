/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : December 06,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contain the definition of MySql class, which will  be used
///        to communicate with the database
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
import 'dart:io';

import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';

class MySQL {
  static late var Connection;
  static var Connected = false;
  static var Settings = new ConnectionSettings(
      host: 'sql4.freemysqlhosting.net',
      port: 3306,
      user: 'sql4456852',
      password: '4byTnPaCr7',
      db: 'sql4456852');

  MySQL();

  /// We use this method at the start, so we minimize the requests for connection,hence improving performance

  //This methods tries to create a connection between the server( database host), and if the
  // is established, it sets the Static Class variable Connected to true.
  static Future<void> getConnection(context) async {
    try{
      Connection = await MySqlConnection.connect(Settings);
      Connected = true;
    }
    catch(e){} // do nothing, because query method will handle the exception
  }

  //This method sends a query to the database, and returns the result
  static Future<dynamic> query(String query,context,{callingEditADD= false, removePreContext=true}) async {
    try {// executes the query
      try { // if this try runs, means connection was established, and there is an internet connection
        return await Connection.query(query); // return the results
      } catch (e) { //if  the internet connection was disconnection, socket(connection), so we
        // see if the connection is back, we try to  remake th connection and run the query again
        try {
          await getConnection(context);
          return await Connection.query(query);
        } on Exception catch (e) {print("Exception is :"+e.toString());// if it fails, means we still have no internet connection, so we throw an exception
          throw Exception(e);}}
    } catch (e) {print("exception : "+e.toString());
      if(callingEditADD) Navigator.pop(context); // removes the extra spinner, if called by the editAddScreen
      showErrorMsg(context,removePreContext: removePreContext); return false;  }
  }
  static Future<dynamic> queryDuplication(String query,context) async {
    try{Connection.query(query);}
    on Exception catch(e){
      if(e.toString().trim().compareTo("Bad state: Cannot write to socket, it is closed")==0) //if internet connection error
      showErrorMsg(context);}//display error message
   //else do nothing
   }
  static void showErrorMsg(context, {removePreContext=true}){
    showDialog(context: context,
        builder: (context)=>AlertDialog(
          title: Text("Error"),content: Text("There seem to be some issue, try checking your internet connection, if the error still persists, contact the developers."),
          actions: [TextButton(onPressed: () {
            if(removePreContext)Navigator.pop(context);
            Navigator.pop(context); },
            child: Text("Okay"),)],
        ));}
}
