import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        // height: 45,
        padding:  const EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius:  BorderRadius.circular(8),color: Colors.blue),
        child: Text(message,style: GoogleFonts.tajawal(fontSize: 15,color: Colors.white),),



      ),
    );
  }
}
