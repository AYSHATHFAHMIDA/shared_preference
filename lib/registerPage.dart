import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameReg_controller=TextEditingController();
  final passwordReg_controller=TextEditingController();
  final confirmpassReg_controller=TextEditingController();

  late SharedPreferences registerData;
  // late bool newreg;

  void dispose(){
    usernameReg_controller.dispose();
    passwordReg_controller.dispose();
    confirmpassReg_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
          child: Container(
            child: Column(
              children:   [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Register Page",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: usernameReg_controller,
                    decoration: InputDecoration(
                      label: Text('enter username'),
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passwordReg_controller,
                    decoration: InputDecoration(
                      label: Text('enter Password'),
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: confirmpassReg_controller,
                    decoration: InputDecoration(
                      label: Text("confirm password"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: ()async{
                    registerData= await SharedPreferences.getInstance();
                    String username=usernameReg_controller.text;
                    String pass=passwordReg_controller.text;
                    String confirmpass=confirmpassReg_controller.text;
                    if(username!=''&& pass!=""&&confirmpass!=''){
                      print('have no null value');
                      if(pass==confirmpass){
                        print('successfull registration');
                        // registerData.setBool('newuser', false);
                        registerData.setString('username', username);
                        registerData.setString('pass', pass);
                        Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>Home()));
                      }
                      else{
                        print('something wrong');
                      }
                    }
                    else{
                      print('error');
                    }
                  },
                      child: Text('Register'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                      },
                      child: Text('already a user?Login'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
