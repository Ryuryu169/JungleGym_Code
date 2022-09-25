import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String MA=('');//メールアドレス格納用
  String PW=('');//パスワード格納用
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
                SizedBox(//タイトル(JungleGym)
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: const Center(
                    child: Text(
                      'Jungle GIM',
                      style:TextStyle(
                        fontSize: 60,
                        fontFamily: 'RussoOne',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(//テキスト(メールアドレス)
                  width: MediaQuery.of(context).size.width-50,
                  height: 60,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Mailaddress',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'RussoOne',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(//テキストフォーム(メールアドレス)
                  width: MediaQuery.of(context).size.width-50,
                  height: 50,
                  color: Colors.white,
                  child: TextFormField(
                    onChanged: (text){
                      MA=text;
                    },
                    style: const TextStyle(
                      fontFamily: 'RussoOne',
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
                SizedBox(//テキスト(パスワード)
                  width: MediaQuery.of(context).size.width-50,
                  height: 60,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Passward',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'RussoOne',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(//テキストフォーム(パスワード)
                  width: MediaQuery.of(context).size.width-50,
                  height: 50,
                  color: Colors.white,
                  child: TextFormField(
                    obscureText: true,
                    onChanged: (text){
                      PW=text;
                    },
                    style: const TextStyle(
                      fontFamily: 'RussoOne',
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    SizedBox(width: (MediaQuery.of(context).size.width-290)/3,),//位置調整用
                    Container(
                      width: 145,
                      height: 90,
                      child: ElevatedButton(//ログインボタン
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          side: const BorderSide(
                            color: Colors.white, //枠線!
                            width: 3, //枠線！
                          ),
                        ),
                        onPressed:(){},
                        child:const Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'RussoOne',
                            color: Colors.white,
                            fontSize: 29,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: (MediaQuery.of(context).size.width-290)/3,),//位置調整用
                    SizedBox(
                      width: 145,
                      height: 90,
                      child: ElevatedButton(//サインアップボタン
                        onPressed:(){},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          side: const BorderSide(//枠線
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        child:const Text(
                          'Sign up',
                          style: TextStyle(
                            fontFamily: 'RussoOne',
                            color: Colors.white,
                            fontSize: 29,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: (MediaQuery.of(context).size.width-290)/3,),//位置調整用
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