import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './main.dart';
class Mypage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyDashBoard(),
      debugShowCheckedModeBanner: false,
    );
  }

}

class MyDashBoard extends StatefulWidget{
  @override
  State<MyDashBoard> createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {

  late SharedPreferences registerData;
  late String username;

  @override
  void initState(){
    super.initState();
    initial();
  }
  void initial()async{
    registerData=await SharedPreferences.getInstance();
    setState(() {
      username=registerData.getString('username')!;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            children: [
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'hello $username',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: (){
                      registerData.setBool('newuser', true);
                      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>MyApp()));
                    },
                    child: Text("LogOut")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}