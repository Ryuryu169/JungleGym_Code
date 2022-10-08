import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 100,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Center(
                    child: Text(
                      'Jungle GIM',
                      style:TextStyle(
                        fontSize: 60,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width-50,
                  height: 60,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Mailaddress',
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width-50,
                  height: 50,
                  color: Colors.white,
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width-50,
                  height: 60,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Passward',
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width-50,
                  height: 50,
                  color: Colors.white,
                  child: TextFormField(
                    obscureText: true,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    SizedBox(width: (MediaQuery.of(context).size.width-290)/3,),
                    Container(
                      width: 145,
                      height: 90,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          side: const BorderSide(
                            color: Colors.white, //枠線!
                            width: 3, //枠線！
                          ),
                        ),
                        onPressed:(){},
                        child:const Text(
                          'src.Login',
                          style: TextStyle(
                            fontSize: 29,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: (MediaQuery.of(context).size.width-290)/3,),
                    Container(
                      width: 145,
                      height: 90,
                      child: ElevatedButton(
                        onPressed:(){},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          side: const BorderSide(
                            color: Colors.white, //枠線!
                            width: 3, //枠線！
                          ),
                        ),
                        child:const Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 29,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: (MediaQuery.of(context).size.width-290)/3,),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}