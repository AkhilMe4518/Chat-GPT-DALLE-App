import 'package:flutter/material.dart';

class JustLoadingWidget extends StatefulWidget {
  const JustLoadingWidget({super.key});
  @override
  State<JustLoadingWidget> createState() => _JustLoadingWidgetState();
}

class _JustLoadingWidgetState extends State<JustLoadingWidget>
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
                width: 20,
                height: 20,
                child: Image.asset(
                  "assets/images/logo.png",
                  color: const Color.fromARGB(255, 158, 8, 172),
                ),
              )),
        ],
      ),
    );
  }
}
