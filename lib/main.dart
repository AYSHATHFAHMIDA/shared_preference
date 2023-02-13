import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preference/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:device_preview/device_preview.dart';

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

  late SharedPreferences logindata;
  late bool newuser;

  void initState(){
    check_if_already_login();
  }

  void check_if_already_login() async{
    logindata=await SharedPreferences.getInstance();
    newuser=(logindata.getBool('newuser')??true);
    if(newuser==false){
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>MyDashBoard()));
    }
  }
  void dispose(){
    username_controller.dispose();
    password_controller.dispose();
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
                      String username =username_controller.text;
                      String password=password_controller.text;
                      if(username!=''&&password!=''){
                        print('successfull');

                        logindata.setBool('newuser', false);
                        logindata.setString('username', username);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyDashBoard()));
                      };

                    },
                    child: Text('Login')),
              ),
            ],
          ),
        ),
      ),
    );
  }


}