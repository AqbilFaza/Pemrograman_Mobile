import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/records_provider.dart';
import '../models/record.dart';
import 'edit_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedYear;

  @override
  void initState() {
    super.initState();
    Provider.of<RecordsProvider>(context, listen: false).fetchRecords();
  }

  void _filterByYear(String? year) {
    setState(() {
      _selectedYear = year;
    });
  }

  @override
  Widget build(BuildContext context) {
    final recordsProvider = Provider.of<RecordsProvider>(context);

    List<Record> filteredRecords = recordsProvider.records;
    if (_selectedYear != null && _selectedYear!.isNotEmpty) {
      filteredRecords = recordsProvider.records.where((record) {
        return record.tanggal.year.toString() == _selectedYear;
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tempat Sholat Id'),
        actions: [
          DropdownButton<String>(
            value: _selectedYear,
            hint: Text('Pilih Tahun', style: TextStyle(color: Colors.white)),
            items: _getYearDropdownItems(recordsProvider.records),
            onChanged: _filterByYear,
          ),
        ],
      ),
      body: recordsProvider.records.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: filteredRecords.length,
        itemBuilder: (ctx, index) {
          final record = filteredRecords[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.mosque, size: 35),
              title: Text(record.tempat),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Imam: ${record.imam}'),
                  Text('Khatib: ${record.khatib}'),
                  Text('Jumlah Jamaah: ${record.jumlahJamaah}'),
                  Text('Topik Khutbah: ${record.topikKhutbah}'),
                  Text('Jenis Sholat: ${record.jenisSholat}'),
                  Text('Tanggal: ${record.tanggal.day}/${record.tanggal.month}/${record.tanggal.year}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => EditScreen(record.id),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => EditScreen(null),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getYearDropdownItems(List<Record> records) {
    final years = records.map((record) => record.tanggal.year.toString()).toSet().toList();
    years.sort((a, b) => int.parse(b).compareTo(int.parse(a)));

    return years.map((year) {
      return DropdownMenuItem<String>(
        value: year,
        child: Text(year),
      );
    }).toList();
  }
}
