import 'package:flutter/cupertino.dart';

const String onlineURL = "pimnackend.herokuapp.com";
const String localURL = "10.0.2.2:3000";
// const String localURL = "10.0.2.2:3000";

//user
const String LOGIN = "/user/login/";
const String SIGNUP = "/user/signup";
const String USERDATAPROTECTED = "/user/protected/";
const String UPDATEPROFILE = "/user/updateProfile/";
const String USEREXIST = "/user/userExist/";
const String UPDATEPASSWORD = "/user/updatePassword/";
//general planing
const String POSTSCHEDULE = "/schedule/addSchedule/";
const String GETALLGENERALPLANNING = "/generalPlaning/getAllGeneralPlaning/";

//events
const String GETALLEVENTS = "/events/getAllEvents/";
const String LIKEEVENT = "/events/likeEvent/";
const String UNLIKEEVENT = "/events/unlikeEvent/";

//Mail
const String SENDMAIL = "/sendMail/sendEmail/";

//Notifications
const String SENDNOTIF = "/pushNotif/sendNotif";
