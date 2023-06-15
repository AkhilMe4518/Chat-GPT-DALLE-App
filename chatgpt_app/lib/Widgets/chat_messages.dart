import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key, required this.text, required this.sender});
  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 35,
          width: 65,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 194, 115, 215),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(25),
                right: Radius.circular(25),
              )),
          child: Center(
              child: Text(
            sender,
            style: GoogleFonts.quattrocento(
                fontSize: 15, fontWeight: FontWeight.w600),
          )),
        ).px12().py8(),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            width: 500,
            child: Text(
              text,
              style: GoogleFonts.roboto(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
