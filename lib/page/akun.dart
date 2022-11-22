import 'dart:async';
import 'dart:convert';

import 'package:bengkel_mekanik/constant/user.dart';
import 'package:bengkel_mekanik/model/GetAkun.dart';
import 'package:bengkel_mekanik/widget/appbarlain.dart';
import 'package:bengkel_mekanik/widget/button_widget.dart';
import 'package:bengkel_mekanik/widget/number_widget.dart';
import 'package:bengkel_mekanik/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AkunSaya extends StatefulWidget {
  const AkunSaya({super.key});

  @override
  State<AkunSaya> createState() => _AkunSayaState();
}

class _AkunSayaState extends State<AkunSaya> {
  // final user = "testesji";
  int id = 0;
  String nama = "-",
      email = "-",
      product = "-",
      gambar = "default-profile.jpeg",
      barang = "0",
      pesanan = "0",
      rating = "0",
      aktif = "n";
  // String bukatutup = "n";
  String statusbuka = "Tutup";
  _ambil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('mekanik_login')!;
    });
    final response = await http.get(
      Uri.parse("http://mekanik-mks.balconteach.my.id/profilemekanik/$id"),
    );
    final data = jsonDecode(response.body);
    setState(() {
      nama = data['nama'];
      email = data['email'];
      gambar = data['gambar'];
      aktif = data['aktif'];
      barang = data['banyakbarang'].toString();
      pesanan = data['pesanan'].toString();
      rating = data['rating'].toString();
      if (aktif == 'y') {
        statusbuka = "Buka";
      } else {
        statusbuka = "Tutup";
      }
      print(aktif);
      print(statusbuka);
    });
  }

  _gantiBuka() async {
    if (aktif == 'y') {
      Fluttertoast.showToast(
          msg: "Mohon Tunggu...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
      final response = await http.get(
        Uri.parse("http://mekanik-mks.balconteach.my.id/gantibuka/$id/n"),
      );
      final data = jsonDecode(response.body);
      String stat = data['status'];
      Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        statusbuka = "Tutup";
        aktif = 'n';
      });
    } else if (aktif == 'n') {
      Fluttertoast.showToast(
          msg: "Mohon Tunggu...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
      final response = await http.get(
        Uri.parse("http://mekanik-mks.balconteach.my.id/gantibuka/$id/y"),
      );
      final data = jsonDecode(response.body);
      String stat = data['status'];
      Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        statusbuka = "Buka";
        aktif = 'y';
      });
    } else {
      Fluttertoast.showToast(
          msg: "Kesalahan...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _ambil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: "https://mekanik-mks.balconteach.my.id/img/$gambar",
            onClicked: () {
              print("Tertekan");
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => EditProfilePage()),
              // );
            },
          ),
          const SizedBox(height: 24),
          buildName(nama, email),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbesWidget(barang: barang, pesanan: pesanan, rating: rating),
          const SizedBox(height: 48),
          buildAbout("user"),
        ],
      ),
    );
  }

  Widget buildName(String name, String email) => Column(
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: statusbuka,
        onClicked: () {
          _gantiBuka();
        },
      );

  Widget buildAbout(String about) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}

// }