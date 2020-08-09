import 'dart:convert';
import 'dart:io';
//import 'dart:js';

import 'package:anuwatmarket/models/user_model.dart';
import 'package:anuwatmarket/utility/my_constant.dart';
import 'package:anuwatmarket/wiget/authen.dart';
import 'package:anuwatmarket/wiget/page0.dart';
import 'package:anuwatmarket/wiget/page1.dart';
import 'package:anuwatmarket/wiget/page2.dart';
import 'package:anuwatmarket/wiget/page3.dart';
import 'package:anuwatmarket/wiget/page4.dart';
import 'package:anuwatmarket/wiget/page5.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cash extends StatefulWidget {
  final UserModel userModel;
  Cash({Key key, this.userModel}) : super(key: key);

  @override
  _CashState createState() => _CashState();
}

class _CashState extends State<Cash> {
  String dateTimeString;
  UserModel userModel;

// List Menu iCon
  List<IconData> iconData = [
    Icons.shopping_cart,
    Icons.add_shopping_cart,
    Icons.add_circle,
    Icons.palette,
    Icons.arrow_forward,
    Icons.android
  ];

  // List MenuTitle
  List<String> titles = [
    'ขายสินค้า',
    'สรุปยอดขาย',
    'หมวดหมู่สินค้า',
    'สินค้า',
    'Password',
    'Setup'
  ];

  List<Widget> widgets = [Page0(), Page1(), Page2(), Page3(), Page4(), Page5()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // userModel = widget.userModel; // userModel
    finduserLogin();

    findDateTime();
  }

  Future<Null> finduserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user = preferences.getString('Username');
    String url =
        '${MyConstant().domain}/Aimee/getUserWhereUser.php?isAdd=true&Username=$user';
    Response response = await Dio().get(url);

    var result = jsonDecode(response.data);

    for (var map in result) {
      setState(() {
        userModel = UserModel.fromJson(map);
      });
    }
  }

  void findDateTime() {
    DateTime dateTime = DateTime.now();

    dateTimeString =
        DateFormat('dd • MM • yyyy').format(dateTime); //dateTime.toString();
    print('dateTimeString = $dateTimeString');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildTextTitle(),
            buildTextCash(),
            // Text('body3'),
            buildDivider(),
            buildCategory(),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: buildTitle(),
        actions: <Widget>[
          Row(
            children: <Widget>[
              //Text(userModel.username),
              Text(userModel == null
                  ? ''
                  : 'User: ${userModel.username}'), // เพราะเปิดมา ครั้งแรก อาจจะยังไม่มีค่า
              SizedBox(
                width: 10,
              ),

              //Text(userModel.fullname),
              Text(userModel == null ? '' : 'User: ${userModel.fullname}'),
            ],
          ),
          //Text('Name'),
          IconButton(
              tooltip: 'Exit App',
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                //  exit(0); //Close Application ไปเลย

                //clear ค่าใน Preferences
                await _ClearPreferences();

                //ไปหน้า Login
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Authen()),
                    (route) => false);
              })
        ],
      ),
    );
  }

  List<Widget> createCard() {
    List<Widget> list = List();
    int index = 0;

    for (var title in titles) {
      Widget widget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          createMyCard(index),
          // Text(titles[index]) // ชื่อเมนู
          Text(
            title,
            style: TextStyle(color: Colors.black87),
          ) // ชื่อเมนู//
        ],
      );
      list.add(widget);
      index++;
    }

    return list;
  }

  Widget createMyCard(int index) {
    return GestureDetector(
      onTap: () {
        print('Click index $index');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widgets[index]),  //ถ้า context แดง ให้ Remark import Dart.js ออกเพราะ เป็น Bug
        ); //
      },
      child: Card(
        shape:
            // RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // ลบเหลี่ยม
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)), // ทำให้กลม
        color: Colors.blue.shade800, // สีพื้น ของ Card
        child: Container(
          padding: EdgeInsets.all(16), // ขยายวงกลมรอบ Icon
          child: Icon(
            iconData[index],
            size: 72,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildCategory() => GridView.extent(
        //  mainAxisSpacing: 20.0,
        crossAxisSpacing: 5.0,
        shrinkWrap: true, // ให้ทำการขยาย Element ออกให้หมดไม่มีการบดบัง
        physics: ScrollPhysics(),
        maxCrossAxisExtent: 200,
        children: createCard(),
      );

  Widget buildDivider() => Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: Divider(
          thickness: 3.0,
          color: Colors.black38,
        ),
      );

  Widget buildTextCash() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('5,000.00 บาท'),
        ],
      );

  Widget buildTextTitle() => Container(
        margin: EdgeInsets.only(top: 16, left: 8),
        child: Row(
          children: <Widget>[
            Text('ยอดขายวันนี้ :'),
          ],
        ),
      );

  Future _ClearPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  Widget buildTitle() => Column(
        children: <Widget>[
          Text(
            'Arale Cash',
            style: TextStyle(),
          ),
          Text(
            dateTimeString,
            style: TextStyle(fontSize: 16),
          ),
        ],
      );
}
