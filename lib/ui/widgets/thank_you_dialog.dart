import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showThankYouDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text('شكرا لكم'),
          content: Text('شكرا لكم على مشاركتكم - سيتم إيصال ملاحظاتكم إلى إدارة المياه في مدينة عزاز أسبوعياً كل يوم أحد'),
          actions: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text('حسنا'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}