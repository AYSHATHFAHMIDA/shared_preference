import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preference/Dashboard.dart';
import 'package:shared_preference/registerPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => Home(),
  ),
);

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    );

  }
}
class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final username_controller=TextEditingController();
  final password_controller=TextEditingController();

  late SharedPreferences registerData;
  late bool newuser;
  late String username;
  late String Pass;


  void initState(){
    check_if_already_login();
    getvalue();
  }
  void getvalue()async{
    registerData=await SharedPreferences.getInstance();
    setState(() {
      username=registerData.getString('username')!;
      Pass=registerData.getString('pass')!;
    });
  }

  void check_if_already_login() async{
    registerData=await SharedPreferences.getInstance();
    newuser=(registerData.getBool('newuser')??true);
    if(newuser==false){
      print('already logged');
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>MyDashBoard()));
    }
    else{
      print('somethig wrong');
    }
  }
  void dispose(){
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 500,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("LoginPage!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: username_controller,
                  decoration: InputDecoration(
                    label: Text("username"),
                    border: OutlineInputBorder(),
                  ),

                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: password_controller,
                  decoration: InputDecoration(
                    label: Text('password'),
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: (){
                      String user_name =username_controller.text;
                      String password=password_controller.text;
                      if(user_name!=''&&password!=''&& user_name==username && password==Pass){
                        print('successfull login');
                        registerData.setBool('newuser', false);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyDashBoard()));
                      }
                      else{
                        print('errorrr');
                      }

                    },
                    child: Text('Login')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>RegisterPage()));
                    },
                    child: Text('new user?Register first!')
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}