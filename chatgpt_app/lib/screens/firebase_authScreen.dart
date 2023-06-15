import 'package:chatgpt_app/Widgets/loading_widget.dart';
import 'package:chatgpt_app/screens/introScreen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

final _firebase = FirebaseAuth.instance;

class FirebaseAuthScreen extends StatefulWidget {
  const FirebaseAuthScreen({super.key});

  @override
  State<FirebaseAuthScreen> createState() => _FirebaseAuthScreenState();
}

class _FirebaseAuthScreenState extends State<FirebaseAuthScreen> {
  bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController _username_controller = TextEditingController();
    TextEditingController _passcode_controller = TextEditingController();

    void _submit() async {
      setState(() {
        _isloading = true;
      });
      try {
        await _firebase.signInWithEmailAndPassword(
            email: _username_controller.text,
            password: _passcode_controller.text);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IntroScreen(),
            ));
        setState(() {
          _isloading = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            e.toString().substring(e.toString().indexOf(']') + 1),
          )),
        );
      }
      setState(() {
        _isloading = false;
      });
      _passcode_controller.clear();
      _username_controller.clear();
    }

    // final pageController = PageController(initialPage: 1);

    return Scaffold(
      appBar: AppBar(
          title: Text(
        "MyChatGptApp",
        style: GoogleFonts.montserrat(),
      )),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isloading) LoadingWidget(),
            if (!_isloading)
              Card(
                shadowColor: Color.fromARGB(255, 178, 6, 240),
                elevation: 10,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      TextField(
                          controller: _username_controller,
                          decoration: InputDecoration.collapsed(
                              hintText: "@gmail.com")),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      TextField(
                          obscureText: true,
                          controller: _passcode_controller,
                          decoration: InputDecoration.collapsed(
                              hintText: "Alteast 6 characters")),
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 10,
            ),
            if (!_isloading)
              ElevatedButton.icon(
                icon: Container(
                  child: Image.asset('assets/images/logo.png'),
                  height: 23,
                  width: 23,
                ),
                onPressed: _submit,
                label: Text("Submit"),
              ),
          ],
        ),
      ),
    );
  }
}
