import 'package:flutter/material.dart';

class Page0 extends StatefulWidget {
  @override
  _Page0State createState() => _Page0State();
}

class _Page0State extends State<Page0> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 0'),
      ),
      body: Column(
        children: <Widget>[
          buildAddbtn(),
          Text('body2'),
          Text('body3'),
          Text('body4'),
          Text('body5'),
          Text('body6'),
          Text('body7'),
        ],
      ),
    );
  }

  Widget buildAddbtn() => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: Icon(Icons.add_circle), onPressed: null),
          IconButton(icon: Icon(Icons.remove_circle), onPressed: null),
        ],
      );
}
