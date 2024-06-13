import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/record.dart';

class RecordsProvider with ChangeNotifier {
  List<Record> _records = [];

  List<Record> get records {
    return [..._records];
  }

  Future<void> fetchRecords() async {
    final url = 'http://localhost:3000/records';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as List<dynamic>;
      final List<Record> loadedRecords = [];
      for (var recordData in extractedData) {
        loadedRecords.add(Record(
          id: recordData['id'],
          imam: recordData['imam'],
          khatib: recordData['khatib'],
          topikKhutbah: recordData['topikKhutbah'],
          jumlahJamaah: recordData['jumlahJamaah'],
          tempat: recordData['tempat'],
          tanggal: DateTime.parse(recordData['tanggal']),
          jenisSholat: recordData['jenisSholat'],
        ));
      }
      _records = loadedRecords;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addRecord(Record record) async {
    final url = 'http://localhost:3000/records';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(record.toJson()),
      );
      final newRecord = Record(
        id: json.decode(response.body)['id'],
        imam: record.imam,
        khatib: record.khatib,
        topikKhutbah: record.topikKhutbah,
        jumlahJamaah: record.jumlahJamaah,
        tempat: record.tempat,
        tanggal: record.tanggal,
        jenisSholat: record.jenisSholat,
      );
      _records.add(newRecord);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateRecord(String id, Record newRecord) async {
    final url = 'http://localhost:3000/records/$id';
    try {
      await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(newRecord.toJson()),
      );
      final recordIndex = _records.indexWhere((rec) => rec.id == id);
      if (recordIndex >= 0) {
        _records[recordIndex] = newRecord;
        notifyListeners();
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<void> deleteRecord(String id) async {
    final url = 'http://localhost:3000/records/$id';
    try {
      await http.delete(Uri.parse(url));
      _records.removeWhere((rec) => rec.id == id);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateTopikKhutbahJumlahJamaah(String id, String topikKhutbah, int jumlahJamaah) async {
    final url = 'http://localhost:3000/records/$id';
    try {
      await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'topikKhutbah': topikKhutbah,
          'jumlahJamaah': jumlahJamaah,
        }),
      );
      final recordIndex = _records.indexWhere((rec) => rec.id == id);
      if (recordIndex >= 0) {
        _records[recordIndex].topikKhutbah = topikKhutbah;
        _records[recordIndex].jumlahJamaah = jumlahJamaah;
        notifyListeners();
      }
    } catch (error) {
      throw (error);
    }
  }
}