import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mkclient/Pages/MainPage.dart';
import 'package:mkclient/SQL/sqlController.dart';

class order_page extends StatefulWidget {
  _order_page createState() => _order_page();
}

class _order_page extends State<order_page> {
  TextStyle rejectFontStyle = TextStyle(
      color: Color(0xffcc3131), fontSize: 22, fontWeight: FontWeight.w900);
  TextStyle confirmFontStyle = TextStyle(
      color: Color(0xff5745bb), fontSize: 22, fontWeight: FontWeight.w900);
  TextStyle headerFontStyle = TextStyle(
      color: Color(0xff7a614c), fontSize: 30, fontWeight: FontWeight.w900);
  TextStyle tableFontStyle = TextStyle(
      color: Color(0xff7a614c), fontSize: 25, fontWeight: FontWeight.w900);
  TextStyle sendFontStyle =
      TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900);
  TextStyle nameFontStyle = TextStyle(
      color: Color(0xff7a614c), fontSize: 20, fontWeight: FontWeight.w900);
  TextStyle priceFontStyle = TextStyle(color: Color(0xff7a614c), fontSize: 18);
  TextStyle textTotalFontStyle = TextStyle(
      color: Color(0xff5745bb), fontSize: 23, fontWeight: FontWeight.w900);
  TextStyle priceTotalFontStyle = TextStyle(
      color: Color(0xffcc3131), fontSize: 23, fontWeight: FontWeight.w900);
  DatabaseHelper databaseHelper = DatabaseHelper.internal();
  List<Map<String, dynamic>> listCart;
  List<DocumentSnapshot> listCartDetail;
  TextEditingController _tableNumber = TextEditingController();
  double sum;
  final _db = Firestore.instance;
  Future loadCart() async {
    double tmp = 0;
    var jsonData = await databaseHelper.getCart();
    List<DocumentSnapshot> jsonDetail = List<DocumentSnapshot>();
    setState(() {
      listCart = jsonData;
      print(listCart);
    });
    for (int i = 0; i < listCart.length; i++) {
      await _db
          .collection('menu')
          .document(listCart[i]['order_id'])
          .get()
          .then((data) {
        jsonDetail.add(data);
        tmp += data.data['price'];
      });
    }
    setState(() {
      listCartDetail = jsonDetail;
      sum = tmp;
    });
  }

  Future resetCart() async {
    await databaseHelper.clearCart();
    loadCart();
  }

  Future sendOrder(String table) async {
    print(listCart);
    await _db
        .collection('orders')
        .add({'date': DateTime.now().toUtc(),'table': table, 'orders': listCart});
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              "ส่งออเดอร์เรียบร้อย",
              style: headerFontStyle,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("ตกลง"),
                onPressed: () {
                  resetCart();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  String toTypeFolder(String type) {
    String folder;
    if (type == "เนื้อ") {
      // setState(() {
      folder = "Meat";
      // });
    } else if (type == "เครื่องดื่ม") {
      // setState(() {
      folder = "Drink";
      // });
    } else if (type == "ลูกชิ้น") {
      // setState(() {
      folder = "Look Chin";
      // });
    } else if (type == "เส้น") {
      // setState(() {
      folder = "Noddle";
      // });
    } else if (type == "ทะเล") {
      // setState(() {
      folder = "Sea Food";
      // });
    } else if (type == "ผัก") {
      // setState(() {
      folder = "Vegetable";
      // });
    }
    return folder;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCart();
  }

  @override
  Widget build(BuildContext context) {
    confirmDialog() {
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
                                "ระบุเลขโต๊ะ",
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
                                controller: _tableNumber,
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
                              sendOrder(_tableNumber.text);
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

    return Container(
      color: Color(0xffffefdc),
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            alignment: Alignment.center,
            child: Text(
              "ออเดอร์",
              style: headerFontStyle,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "เมนู",
                              style: tableFontStyle,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "จำนวน",
                              style: tableFontStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: listCart == null ? 0 : listCart.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          return index == listCart.length
                              ? Container(
                                  height: 100,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "ราคารวม",
                                          style: textTotalFontStyle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        child: Text(
                                          sum == null
                                              ? "กำลังคำนวณ"
                                              : "${sum.toString()} บาท",
                                          style: priceTotalFontStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  height: 150,
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 120,
                                              child: Image.asset(
                                                  "assets/${toTypeFolder(listCart[index]['order_type'])}/${listCart[index]['order_id']}.jpg"),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                color: Colors.white,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        listCartDetail == null
                                                            ? "Loading"
                                                            : listCartDetail[
                                                                    index]
                                                                .data['name'],
                                                        style: nameFontStyle,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        listCartDetail == null
                                                            ? "Loading"
                                                            : "${listCartDetail[index].data['price'].toString()} บาท",
                                                        style: priceFontStyle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          width: 100,
                                          alignment: Alignment.center,
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 50,
                                            width: 85,
                                            child: Text(
                                              listCart[index]['order_num']
                                                  .toString(),
                                              style: nameFontStyle,
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
          ),
          Container(
            height: 80,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    resetCart();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xff882727),
                    ),
                    alignment: Alignment.center,
                    height: 50,
                    width: 150,
                    child: Text(
                      "รีเซ็ท",
                      style: sendFontStyle,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    confirmDialog();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xff144b14),
                    ),
                    alignment: Alignment.center,
                    height: 50,
                    width: 150,
                    child: Text(
                      "ส่งออเดอร์",
                      style: sendFontStyle,
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
