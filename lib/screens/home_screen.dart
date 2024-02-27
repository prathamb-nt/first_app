import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> _onShow() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? email = prefs.getString('email');
  String? password = prefs.getString('password');

}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  Future<String?> _onShow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    return email;

  }

 @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Text(_onShow.toString())),
    );
  }
}
