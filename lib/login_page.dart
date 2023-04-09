import 'package:flutter/material.dart';
import 'halaman_utama.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "";
  String password = "";
  bool isLoginSuccess = true;
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF1E90FF),
        body: ListView(
          children: [
            Card(
              elevation: 30,
              shadowColor: Colors.black,
              color: Colors.white,
              margin: EdgeInsets.all(40),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 0, left: 0, right: 0, top: 20),
                  child: Center(
                      child: Image.asset(
                        'images/logo.png',
                        width: 160,
                        height: 160,
                      )),

                ),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                  child: Center(
                    child: TextField(
                      enabled: true,
                      onChanged: (value) {
                        username = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color:
                              (isLoginSuccess) ? Colors.blue : Colors.red),
                        ),
                        labelText: "Username",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 60),
                  child: Center(
                    child: TextField(
                      enabled: true,
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: isHide,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.tealAccent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color:
                              (isLoginSuccess) ? Colors.blue : Colors.red),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              isHide = !isHide;
                            });
                          },
                          child: Icon(
                            isHide ? Icons.visibility_off : Icons.visibility,
                            color: isHide ? Colors.grey : Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 30, left: 120, right: 120, top: 20),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        String text = "";
                        if (password == "admin" && username == "admin") {
                          setState(() {
                            text = "Login Success";
                            isLoginSuccess = true;
                          });
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                                return const HalamanUtama();
                              }));
                        } else {
                          setState(() {
                            text = "Login Failed";
                            isLoginSuccess = false;
                          });
                        }
                        SnackBar snackBar = SnackBar(content: Text(text));

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: const Text("Login"),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40),
                          primary: (isLoginSuccess) ? Colors.blue : Colors.red,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder()),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}