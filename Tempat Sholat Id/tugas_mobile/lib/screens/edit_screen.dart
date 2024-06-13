import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/records_provider.dart';
import '../models/record.dart';

class EditScreen extends StatefulWidget {
  final String? recordId;

  EditScreen(this.recordId);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _tempatOptions = {
    '1': 'Masjid Al-Akbar, Jl. Mawar No 01',
    '2': 'Masjid Baiturrahman, Jl. Melati No 02',
    '3': 'Masjid Al-Hidayah, Jl. Kamboja No 03',
    '4': 'Masjid An-Nur, Jl. Anggrek No 04',
    '5': 'Masjid Taqwa, Jl. Tulip No 05',
  };

  String? _imam;
  String? _khatib;
  String? _topikKhutbah;
  int? _jumlahJamaah;
  String? _tempatId;
  DateTime? _tanggal;
  String? _jenisSholat;

  @override
  void initState() {
    super.initState();
    if (widget.recordId != null) {
      final recordsProvider = Provider.of<RecordsProvider>(context, listen: false);
      final existingRecord = recordsProvider.records.firstWhere((rec) => rec.id == widget.recordId);
      _imam = existingRecord.imam;
      _khatib = existingRecord.khatib;
      _topikKhutbah = existingRecord.topikKhutbah;
      _jumlahJamaah = existingRecord.jumlahJamaah;
      _tempatId = _tempatOptions.keys.firstWhere((id) => _tempatOptions[id]!.contains(existingRecord.tempat));
      _tanggal = existingRecord.tanggal;
      _jenisSholat = existingRecord.jenisSholat;
    }
  }

  void _deleteRecord() {
    if (widget.recordId != null) {
      final recordsProvider = Provider.of<RecordsProvider>(context, listen: false);
      recordsProvider.deleteRecord(widget.recordId!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final recordsProvider = Provider.of<RecordsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recordId == null ? 'Tambah Data' : 'Edit Data'),
        actions: [
          if (widget.recordId != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _deleteRecord,
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _imam,
                  decoration: InputDecoration(labelText: 'Imam'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan nama imam';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _imam = value;
                  },
                ),
                TextFormField(
                  initialValue: _khatib,
                  decoration: InputDecoration(labelText: 'Khatib'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan nama khatib';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _khatib = value;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _tempatId,
                  decoration: InputDecoration(labelText: 'Tempat'),
                  items: _tempatOptions.keys.map((String id) {
                    return DropdownMenuItem<String>(
                      value: id,
                      child: Text(_tempatOptions[id]!.split(',')[0]),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _tempatId = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih tempat';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _tempatId = value;
                  },
                ),
                // Menampilkan alamat berdasarkan tempat yang dipilih
                Text(_tempatOptions[_tempatId]?.split(',')[1] ?? ''),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Tanggal'),
                  readOnly: true,
                  controller: TextEditingController(
                    text: _tanggal == null
                        ? ''
                        : '${_tanggal!.day}/${_tanggal!.month}/${_tanggal!.year}',
                  ),
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _tanggal ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != _tanggal) {
                      setState(() {
                        _tanggal = pickedDate;
                      });
                    }
                  },
                  validator: (value) {
                    if (_tanggal == null) {
                      return 'Pilih tanggal';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text('Sholat Idul Fitri'),
                        value: 'Idul Fitri',
                        groupValue: _jenisSholat,
                        onChanged: (value) {
                          setState(() {
                            _jenisSholat = value as String?;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text('Sholat Idul Adha'),
                        value: 'Idul Adha',
                        groupValue: _jenisSholat,
                        onChanged: (value) {
                          setState(() {
                            _jenisSholat = value as String?;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                if (widget.recordId != null) ...[
                  TextFormField(
                    initialValue: _topikKhutbah,
                    decoration: InputDecoration(labelText: 'Topik Khutbah'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan topik khutbah';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _topikKhutbah = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _jumlahJamaah?.toString(),
                    decoration: InputDecoration(labelText: 'Jumlah Jamaah'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan jumlah jamaah';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Masukkan angka yang valid';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _jumlahJamaah = int.tryParse(value!);
                    },
                  ),
                ],
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final tempat = _tempatOptions[_tempatId]?.split(',')[0] ?? '';
                      if (widget.recordId == null) {
                        recordsProvider.addRecord(
                          Record(
                            id: Uuid().v4(),
                            imam: _imam!,
                            khatib: _khatib!,
                            topikKhutbah: '',
                            jumlahJamaah: 0,
                            tempat: tempat,
                            tanggal: _tanggal!,
                            jenisSholat: _jenisSholat!,
                          ),
                        ).then((_) => Navigator.of(context).pop());
                      } else {
                        recordsProvider.updateRecord(
                          widget.recordId!,
                          Record(
                            id: widget.recordId!,
                            imam: _imam!,
                            khatib: _khatib!,
                            topikKhutbah: _topikKhutbah!,
                            jumlahJamaah: _jumlahJamaah!,
                            tempat: tempat,
                            tanggal: _tanggal!,
                            jenisSholat: _jenisSholat!,
                          ),
                        ).then((_) => Navigator.of(context).pop());
                      }
                    }
                  },
                  child: Text(widget.recordId == null ? 'Tambah' : 'Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
