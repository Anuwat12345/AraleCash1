import 'dart:io';

import 'package:anuwatmarket/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Cash extends StatefulWidget {
  final UserModel userModel;
  Cash({Key key, this.userModel}) : super(key: key);

  @override
  _CashState createState() => _CashState();
}

class _CashState extends State<Cash> {
  String dateTimeString;
  UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userModel = widget.userModel;

    findDateTime();
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
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: buildTitle(),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Text('User: ${userModel.username}'),
              SizedBox(
                width: 10,
              ),
              Text(userModel.fullname),
            ],
          ),
          //Text('Name'),
          IconButton(
              tooltip: 'Exit App',
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                exit(0); //exit Appl
              })
        ],
      ),
    );
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
