// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:suggestor/backend.dart';
import 'package:suggestor/homepage.dart';
import 'package:suggestor/loading.dart';

import 'data_structures.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool error = false;
  var username = TextEditingController();
  var password = TextEditingController();
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
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
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
                  )),
            ),
            Expanded(
                flex: 2,
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
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: TextField(
                          controller: username,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: (error) ? Colors.red : Colors.white,
                            hintText: 'User name',
                            hintStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              borderSide: BorderSide(
                                color: (error) ? Colors.white : Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 50),
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: TextField(
                          controller: password,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: (error) ? Colors.red : Colors.white,
                            hintText: 'Password',
                            hintStyle: TextStyle(fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              borderSide: BorderSide(
                                color: (error) ? Colors.white : Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        error = false;
                        if (username.text == '') {
                          error = true;
                          setState(() {});
                        } else if (password.text == '') {
                          error = true;
                          setState(() {});
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Loading('Verifying credentials'),
                            ),
                          );
                          if (await login(username.text, password.text)) {
                            Navigator.pop(context);
                            user = User(username.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          } else {
                            Navigator.pop(context);
                            error = true;
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
