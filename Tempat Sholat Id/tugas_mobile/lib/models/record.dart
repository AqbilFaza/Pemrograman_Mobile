import 'package:flutter/material.dart';

class Record {
  String id;
  String imam;
  String khatib;
  String topikKhutbah;
  int jumlahJamaah;
  String tempat;
  DateTime tanggal;
  String jenisSholat;

  Record({
    required this.id,
    required this.imam,
    required this.khatib,
    required this.topikKhutbah,
    required this.jumlahJamaah,
    required this.tempat,
    required this.tanggal,
    required this.jenisSholat,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'],
      imam: json['imam'],
      khatib: json['khatib'],
      topikKhutbah: json['topikKhutbah'],
      jumlahJamaah: json['jumlahJamaah'],
      tempat: json['tempat'],
      tanggal: DateTime.parse(json['tanggal']),
      jenisSholat: json['jenisSholat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imam': imam,
      'khatib': khatib,
      'topikKhutbah': topikKhutbah,
      'jumlahJamaah': jumlahJamaah,
      'tempat': tempat,
      'tanggal': tanggal.toIso8601String(),
      'jenisSholat': jenisSholat,
    };
  }
}