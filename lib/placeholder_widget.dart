

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class PlaceholderWidget extends StatelessWidget {
 final Color color;

 PlaceholderWidget(this.color);

 @override
 Widget build(BuildContext context) {
   return Container(
     color: color,
   );
 }
}

class TextStyling extends StatelessWidget {
 final bool a;
 final String text;
 final Color colors;
 final double size;
 final FontWeight type;

  TextStyling(this.a,this.text,this.colors,this.size,this.type);
  @override
  Widget build(BuildContext context) {
    return a==true?_textOpensans(text, colors, size, type):_textCabin(text, colors, size, type);
      
    
  }
}

Widget _textOpensans(String text,Color colors,double size,FontWeight type){
  return Text(text,style: GoogleFonts.openSans(
    fontSize:  size,
    fontWeight: type,
    color: colors
  ));
}

Widget _textCabin(String text,Color colors,double size,FontWeight type){
  return Text(text,style: GoogleFonts.cabin(
    fontSize:  size,
    fontWeight: type,
    color: colors
  ));
}
