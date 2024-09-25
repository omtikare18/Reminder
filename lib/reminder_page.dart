// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';  
// ignore: unused_import
import 'package:flutter/services.dart';  
import 'package:flutter_local_notifications/flutter_local_notifications.dart';  
import 'dart:core'; 
void main() {  
  runApp(MyApp());  
}  
  
// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
 return MaterialApp( 
  key: GlobalKey(), 
  title: 'Reminder App',  
  theme: ThemeData(  
    primarySwatch: Colors.blue,  
   ),  
   home: ReminderPage(),  
   );  
  }  
}  
  
// ignore: use_key_in_widget_constructors
class ReminderPage extends StatefulWidget {  
  @override  
  // ignore: library_private_types_in_public_api
  State<ReminderPage> createState() => _ReminderPageState();  
}  
  
class _ReminderPageState extends State<ReminderPage> {  
  String _selectedDay = 'Monday';  
  TimeOfDay _selectedTime = TimeOfDay.now();  
  String _selectedActivity = 'Wake up';  
  
  final _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];  
  final _activities = ['Wake up', 'Go to gym', 'Breakfast', 'Meetings', 'Lunch', 'Quick nap', 'Go to library', 'Dinner', 'Go to sleep'];  
  
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
  get localTimezone => null;  
  
  @override  
  void initState() {  
  super.initState();  
  initializeNotifications();  
  }  
  
void initializeNotifications() async {  
   const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings = InitializationSettings( 
   android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(  
   initializationSettings,
    onSelectNotification: onSelectNotification,  
  // ignore: prefer_const_constructors
   
   
        
     );  
  }

  
  Future<dynamic> onSelectNotification(String? payload) async {  
  // Handle notification tap  
  }  
void scheduleNotification(dynamic selectedDate) async {
  // Assuming _selectedDate is a DateTime object representing the selected date
  DateTime scheduledDateTime = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    _selectedTime.hour,
    _selectedTime.minute,
  );

  await flutterLocalNotificationsPlugin.schedule(
    0, // notification id
    _selectedActivity, // notification title
    'Reminder', // notification body
    scheduledDateTime, // notification scheduled time
    NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        channelDescription: 'channel_description',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
  );
}

  @override  
  Widget build(BuildContext context) {  
  return Scaffold(  
  appBar: AppBar(  
    title: const Text('Reminder App'),  
  ),  
  body: Center(  
    child: Column(  
    mainAxisAlignment: MainAxisAlignment.center,  
    children: <Widget>[  
    DropdownButton<String>(  
      value: _selectedDay,  
      onChanged: (String? newValue) {  
      setState(() {  
      _selectedDay = newValue ?? _selectedDay;  
      });  
      },  
      items: _days.map((String day) {  
      return DropdownMenuItem(  
      child: Text(day),  
      value: day,  
      );  
      }).toList(),  
    ),  
    const SizedBox(height: 20),  
    ElevatedButton(  
      onPressed: () async {  
      final TimeOfDay? picked = await showTimePicker(  
      context: context,  
      initialTime: _selectedTime,  
      );  
      // ignore: unnecessary_null_comparison
      if (picked != null) {  
      setState(() {  
        _selectedTime = picked;  
      });  
      }  
      },  
      child: const Text('Select Time'),  
    ),  
    const SizedBox(height: 20),  
    DropdownButton(  
      value: _selectedActivity,  
      onChanged: (String? newValue) {  
      setState(() {  
      _selectedActivity = newValue!;  
      });  
      },  
      items: _activities.map((String activity) {  
      return DropdownMenuItem(  
      // ignore: duplicate_ignore
      // ignore: sort_child_properties_last
      child: Text(activity),  
      value: activity,  
      );  
      }).toList(),  
    ),  
    const SizedBox(height: 20),  
    ElevatedButton(  
      onPressed: scheduleNotification,  
      child: const Text('Schedule Reminder'),  
    ),  
    ],  
    ),  
  ),  
  );  
  }  
}




