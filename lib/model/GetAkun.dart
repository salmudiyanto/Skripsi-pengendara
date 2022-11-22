// To parse this JSON data, do
//
//     final getAkun = getAkunFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetAkun getAkunFromJson(String str) => GetAkun.fromJson(json.decode(str));

String getAkunToJson(GetAkun data) => json.encode(data.toJson());

class GetAkun {
  GetAkun({
    required this.idMekanik,
    required this.nama,
    required this.alamat,
    required this.latitude,
    required this.longitude,
    required this.email,
    required this.password,
    required this.noHp,
    required this.gambar,
    required this.stat,
    required this.aktif,
  });

  int idMekanik;
  String nama;
  String alamat;
  String latitude;
  String longitude;
  String email;
  String password;
  String noHp;
  String gambar;
  String stat;
  String aktif;

  factory GetAkun.fromJson(Map<String, dynamic> json) => GetAkun(
        idMekanik: json["id_mekanik"],
        nama: json["nama"],
        alamat: json["alamat"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        email: json["email"],
        password: json["password"],
        noHp: json["no_hp"],
        gambar: json["gambar"],
        stat: json["stat"],
        aktif: json["aktif"],
      );

  Map<String, dynamic> toJson() => {
        "id_mekanik": idMekanik,
        "nama": nama,
        "alamat": alamat,
        "latitude": latitude,
        "longitude": longitude,
        "email": email,
        "password": password,
        "no_hp": noHp,
        "gambar": gambar,
        "stat": stat,
        "aktif": aktif,
      };
}
