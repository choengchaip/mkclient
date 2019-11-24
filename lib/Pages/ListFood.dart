import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mkclient/SQL/sqlController.dart';
import 'MainPage.dart';

class list_food extends StatefulWidget {
  String type;
  list_food(this.type);
  _list_food createState() => _list_food(this.type);
}

class _list_food extends State<list_food> {
  String type;
  _list_food(this.type);
  TextStyle headerFontStyle = TextStyle(
      color: Color(0xff7a614c), fontSize: 30, fontWeight: FontWeight.w900);
  TextStyle nameFontStyle = TextStyle(
      color: Color(0xff7a614c), fontSize: 22, fontWeight: FontWeight.w900);
  TextStyle subFontStyle = TextStyle(color: Color(0xff7a614c), fontSize: 18);
  TextStyle selectFontStyle =
      TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900);

  TextStyle rejectFontStyle = TextStyle(
      color: Color(0xffcc3131), fontSize: 22, fontWeight: FontWeight.w900);
  TextStyle confirmFontStyle = TextStyle(
      color: Color(0xff5745bb), fontSize: 22, fontWeight: FontWeight.w900);

  DatabaseHelper databaseHelper = DatabaseHelper.internal();
  final _db = Firestore.instance;
  List<DocumentSnapshot> foodList;
  String folder;

  TextEditingController _num = TextEditingController(text: "1");

  Future getListMenu() async {
    if (this.type == "เนื้อ") {
      setState(() {
        folder = "Meat";
      });
    } else if (this.type == "เครื่องดื่ม") {
      setState(() {
        folder = "Drink";
      });
    } else if (this.type == "ลูกชิ้น") {
      setState(() {
        folder = "Look Chin";
      });
    } else if (this.type == "เส้น") {
      setState(() {
        folder = "Noddle";
      });
    } else if (this.type == "ทะเล") {
      setState(() {
        folder = "Sea Food";
      });
    } else if (this.type == "ผัก") {
      setState(() {
        folder = "Vegetable";
      });
    }

    _db
        .collection('menu')
        .where('type', isEqualTo: this.type)
        .getDocuments()
        .then((docs) {
      setState(() {
        foodList = docs.documents;
      });
    });
  }

  Future addToCart(String id, String type, int number) async {
    databaseHelper.addToCart(id, type, number);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListMenu();
  }

  @override
  Widget build(BuildContext context) {
    double _paddingTop = MediaQuery.of(context).padding.top;

    confirmDialog(String id, String type) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(10),
              content: Container(
                height: 300,
                width: 300,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "ใส่จำนวน",
                                style: headerFontStyle,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              width: 60,
                              height: 100,
                              alignment: Alignment.center,
                              child: TextField(
                                controller: _num,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: headerFontStyle,
                                decoration:
                                    InputDecoration.collapsed(hintText: ""),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              child: Text(
                                "ยกเลิก",
                                style: rejectFontStyle,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              addToCart(id, type, int.parse(_num.text));
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return main_page();
                              }));
                            },
                            child: Container(
                              child: Text("ยืนยัน", style: confirmFontStyle),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      body: Container(
        color: Color(0xffffefdc),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _paddingTop,
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  child: Text(
                    "เลือกอาหาร",
                    style: headerFontStyle,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: foodList == null ? 0 : foodList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 150,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 120,
                            child: Image.asset(
                                "assets/${folder}/${foodList[index].documentID}.jpg"),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      foodList[index].data['name'],
                                      style: nameFontStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Text(
                                      "${foodList[index].data['price'].toString()} บาท",
                                      style: subFontStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              confirmDialog(foodList[index].documentID,
                                  foodList[index].data['type']);
                            },
                            child: Container(
                              width: 100,
                              alignment: Alignment.center,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 85,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: Color(0xff7a614c),
                                ),
                                child: Text(
                                  "เลือก",
                                  style: selectFontStyle,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
