import 'package:flutter/material.dart';

Future<Null> normalDialog(BuildContext _context, String _string) async {
  showDialog(
    context: _context,
    builder: (_context) => SimpleDialog(
      title: Text(_string),
      children: <Widget>[
        FlatButton(onPressed: () => Navigator.pop(_context), child: Text('Ok! ♥')),
      ],
    ),
  );
}
