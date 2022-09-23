// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:suggestor/backend.dart';
import 'package:suggestor/homepage.dart';

import 'loading.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool usernameError = false;
  bool passwordError = false;
  bool emailError = false;
  var username = TextEditingController();
  var password = TextEditingController();
  var email = TextEditingController();
  var passwordConfirm = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: IconButton(
                        iconSize: 50,
                        icon: Icon(
                          Icons.arrow_left,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Container(
                      width: 250,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.orange),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: SizedBox(
                        width: 210,
                        height: 50,
                        child: TextField(
                          controller: username,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                (usernameError) ? Colors.red : Colors.white,
                            hintText: 'User name',
                            hintStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              borderSide: BorderSide(
                                color: (usernameError)
                                    ? Colors.white
                                    : Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: SizedBox(
                        width: 210,
                        height: 50,
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: (emailError) ? Colors.red : Colors.white,
                            hintText: 'Email',
                            hintStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              borderSide: BorderSide(
                                color:
                                    (emailError) ? Colors.white : Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: 210,
                        height: 50,
                        child: TextField(
                          controller: password,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                (passwordError) ? Colors.red : Colors.white,
                            hintText: 'Password',
                            hintStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              borderSide: BorderSide(
                                color: (passwordError)
                                    ? Colors.white
                                    : Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: SizedBox(
                        width: 210,
                        height: 50,
                        child: TextField(
                          controller: passwordConfirm,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                (passwordError) ? Colors.red : Colors.white,
                            hintText: 'Password Confirm',
                            hintStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              borderSide: BorderSide(
                                color: (passwordError)
                                    ? Colors.white
                                    : Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        usernameError = false;
                        passwordError = false;
                        emailError = false;
                        if (username.text == '') {
                          usernameError = true;
                          setState(() {});
                        } else if (email.text == '') {
                          emailError = true;
                        } else {
                          if (password.text == passwordConfirm.text &&
                              password.text != '') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Loading('Verifying username'),
                              ),
                            );
                            if (await signUp(
                                username.text, password.text, email.text)) {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            } else {
                              Navigator.pop(context);
                              usernameError = true;
                              setState(() {});
                            }
                          } else {
                            passwordError = true;
                            setState(() {});
                          }
                        }
                      },
                      child: Text(
                        'Let\'s Go',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.orange),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                          Size(100, 10),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
