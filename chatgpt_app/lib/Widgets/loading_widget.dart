import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});
  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInCirc,
    );
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
              turns: animation,
              child: Container(
                width: 80,
                height: 80,
                child: Image.asset(
                  "assets/images/logo.png",
                  color: const Color.fromARGB(255, 158, 8, 172),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Loading OpenAI....",
            style: GoogleFonts.varela(
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
