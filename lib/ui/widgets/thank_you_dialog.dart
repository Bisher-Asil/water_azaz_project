import 'package:flutter/material.dart';

void showThankYouDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('شكرا لكم'),
        content: Text('شكرا لكم على مشاركتكم - سيتم إيصال ملاحظاتكم إلى إدارة المياه في مدينة عزاز أسبوعياً كل يوم أحد'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}