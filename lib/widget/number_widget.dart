import 'dart:ffi';

import 'package:flutter/material.dart';

class NumbesWidget extends StatefulWidget {
  final String barang, pesanan, rating;
  const NumbesWidget(
      {required this.barang,
      super.key,
      required this.pesanan,
      required this.rating});

  @override
  State<NumbesWidget> createState() => _NumbesWidgetState();
}

class _NumbesWidgetState extends State<NumbesWidget> {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, widget.barang, 'Barang'),
          buildDivider(),
          buildButton(context, widget.pesanan, 'Pesanan'),
          buildDivider(),
          buildButton(context, widget.rating, 'Rating'),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
