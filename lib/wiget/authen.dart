import 'dart:convert';

import 'package:anuwatmarket/models/user_model.dart';
import 'package:anuwatmarket/utility/my_constant.dart';
import 'package:anuwatmarket/utility/normal_dialog.dart';
import 'package:anuwatmarket/wiget/cash.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          //อนุญาตให้ขยับจอขึ้นหลบ keyborad
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildLogo(),
              buildText(),
              buildTextFieldUser(),
              buildTextFieldPassword(),
              buildOutlineButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOutlineButton() => Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        width: 120,
        height: 60,
        child: OutlineButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
            print('user = $user, password = $password');

            if (user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'Please กรอกข้อมูล');
            } else {
              checkAuthen();
            }
          },
          child: Text('Login'),
        ),
      );

  Future<Null> checkAuthen() async {
    String url =
        '${MyConstant().domain}/Aimee/getUserWhereUser.php?isAdd=true&Username=$user';

    await Dio().get(url).then((value) {
      if (value.toString() == 'null') {
        normalDialog(context, 'ไม่พบ $user ในฐานข้อมูล');
      } else {
        print('value= $value');
        var result = json.decode(value.data);
        print('result = $result');
        for (var map in result) {
          //ตัด [] ออก....// จาก [] ให้เหลือ แต่ String
          print('map=$map');
          UserModel model = UserModel.fromJson(map);
          if (password == model.password) {
// สร้าง SharedPreforence เพื่อให้ Appl จำค่าที่เคย Login ไว้แล้วไม่ต้อง Login ใหม่เหมือนกับ Facebook
 
// SharedPreferences preferences = a

///////////
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Cash(userModel: model,),
                ),
                (route) => false);
          } else {
            normalDialog(context, 'Password fail ;w;');
          }
        }
      }
    }).catchError(() {});
  }

  Widget buildTextFieldUser() => Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        width: 300,
        child: TextField(
          onChanged: (value1) => user = value1.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.pink), //color of Lable
            suffixIcon:
                Icon(Icons.account_box, color: Colors.pink), //color of icon
            labelText: 'User',


            
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pink),
              borderRadius: BorderRadius.circular(35),
            ),




            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      );

  Widget buildTextFieldPassword() => Container(
        width: 300,
        child: TextField(
          onChanged: (value2) => password = value2.trim(),
          obscureText: true, // ปิดตัวอักษร
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.lock),
            labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
            ),
          ),
        ),
      );

  Text buildText() => Text(
        'Version 1.0 อาราเล่',
        style: GoogleFonts.itim(
          textStyle: TextStyle(
            fontSize: 30,
            color: Colors.deepPurple.shade900,
            //fontWeight: FontWeight.bold,
            //fontStyle: FontStyle.italic,
          ),
        ),
      );

  Container buildLogo() {
    return Container(
      width: 120,
      child: Image.asset('images/login_logo.jpg'),
    );
  }
}
