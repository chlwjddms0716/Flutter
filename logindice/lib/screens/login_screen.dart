import 'package:flutter/material.dart';

import 'dice.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void onLoginClick() {
    if (idCont.text == "dice" && pwCont.text == "1234") {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => const Dice()));
    } else if (idCont.text == "dice" && pwCont.text != "1234") {
      showPwErrorSnackBar(context);
    } else if (idCont.text != "dice" && pwCont.text == "1234") {
      showIdErrorSnackBar(context);
    } else {
      showSnackBar(context);
    }
  }

  TextEditingController idCont = TextEditingController();
  TextEditingController pwCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
        backgroundColor: Colors.redAccent,
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Center(
                    child: Image.asset(
                      'image/icon.png',
                      width: 180,
                      height: 180,
                    ),
                  ),
                ),
                Form(
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Colors.teal,
                      inputDecorationTheme: const InputDecorationTheme(
                        // TextFiled 위에 정보
                        labelStyle: TextStyle(
                          color: Colors.teal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          TextField(
                            controller: idCont,
                            decoration: const InputDecoration(
                                labelText: 'Enter "dice"'),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: pwCont,
                            decoration: const InputDecoration(
                                labelText: 'Enter "password"'),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ButtonTheme(
                            minWidth: 100,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                ),
                                backgroundColor: Colors.orange,
                              ),
                              onPressed: onLoginClick,
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void showSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('로그인 정보를 다시 확인하세요.'),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.redAccent,
    ),
  );
}

void showIdErrorSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('dice 의 철자를 확인하세요.'),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.redAccent,
    ),
  );
}

void showPwErrorSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('비밀번호가 일치하지 않습니다.'),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.redAccent,
    ),
  );
}
