import 'package:flutter/material.dart';
import 'ListFood.dart';

class all_food extends StatefulWidget {
  _all_food createState() => _all_food();
}

class _all_food extends State<all_food> {
  TextStyle headerFontStyle = TextStyle(
      color: Color(0xff7a614c), fontSize: 30, fontWeight: FontWeight.w900);
  TextStyle optionFontStyle =
      TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffefdc),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 80,
            alignment: Alignment.center,
            child: Text(
              "เลือกประเภท",
              style: headerFontStyle,
            ),
          ),
          Container(
            height: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return list_food("เนื้อ");
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xff7a614c),
                    ),
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    child: Text(
                      "เนื้อ",
                      style: optionFontStyle,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return list_food("ทะเล");
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xff7a614c),
                    ),
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    child: Text(
                      "ทะเล",
                      style: optionFontStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return list_food("เส้น");
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xff7a614c),
                    ),
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    child: Text(
                      "เส้น",
                      style: optionFontStyle,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return list_food("ลูกชิ้น");
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xff7a614c),
                    ),
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    child: Text(
                      "ลูกชิ้น",
                      style: optionFontStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return list_food("ผัก");
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xff7a614c),
                    ),
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    child: Text(
                      "ผัก",
                      style: optionFontStyle,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return list_food("เครื่องดื่ม");
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xff7a614c),
                    ),
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    child: Text(
                      "เครื่องดื่ม",
                      style: optionFontStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
