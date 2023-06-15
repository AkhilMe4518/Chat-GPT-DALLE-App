import 'package:chatgpt_app/screens/chat_screen.dart';
import 'package:chatgpt_app/screens/image_generator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  // dynamic _icon = ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "OpenAI",
        style: GoogleFonts.kaushanScript(),
      )),
      body: SafeArea(
        child: IntroductionScreen(
          showNextButton: false,
          pages: [
            PageViewModel(
              titleWidget: Text(
                "Chat GPT",
                style: GoogleFonts.prociono(
                    textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 60,
                )),
              ),
              bodyWidget: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(),
                        ),
                      );
                    },
                    child: Container(
                        height: 200,
                        width: 200,
                        child: Hero(
                            tag: "chatgpt",
                            child: RotationTransition(
                                turns: animation,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  child: Image.asset(
                                    "assets/images/logo.png",
                                    color:
                                        const Color.fromARGB(255, 158, 8, 172),
                                  ),
                                )))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "OpenAI",
                    style: GoogleFonts.comforter(fontSize: 30),
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    height: 300,
                    width: 300,
                    child: Text(
                        style: GoogleFonts.openSans(),
                        "Introducing ChatGPT \nWe've trained a model called ChatGPT \nwhich interacts in a conversational way. \nThe dialogue format makes it possible for ChatGPT to answer followup questions, admit its mistakes, challenge incorrect premises, and reject inappropriate requests.\n\nTap on the icon above to try CHAT-GPT"),
                  ),
                ],
              ),
            ),
            PageViewModel(
              titleWidget: Text(
                "DALL·E",
                style: GoogleFonts.prociono(
                    textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 60,
                )),
              ),
              bodyWidget: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageGenerator(),
                        ),
                      );
                    },
                    child: Container(
                        height: 200,
                        width: 200,
                        child: Hero(
                            tag: "dalle",
                            child: RotationTransition(
                                turns: animation,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  child: Image.asset(
                                    "assets/images/logo.png",
                                    color:
                                        const Color.fromARGB(255, 158, 8, 172),
                                  ),
                                )))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "OpenAI",
                    style: GoogleFonts.comforter(fontSize: 30),
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    height: 300,
                    width: 300,
                    child: Text(
                        style: GoogleFonts.openSans(),
                        "DALL·E 2 is an AI system that can create realistic images and art from a description in natural language.\n\nTap on the icon above to try DALL·E"),
                  ),
                ],
              ),
            ),
          ],
          showDoneButton: false,
          onDone: () {},
        ),
      ),
    );
  }
}
