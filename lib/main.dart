import 'package:flutter/material.dart';  
import 'reminder_page.dart';  
  
void main() {  
  runApp(MyApp());  
}  
  
// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
  return MaterialApp(  
   title: 'Reminder App',  
 theme: ThemeData(  
 primarySwatch: Colors.blue,  
 ),  
 home: ReminderPage(),  
 );  
  }  
}
