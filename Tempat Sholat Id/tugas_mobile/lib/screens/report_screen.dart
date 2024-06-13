import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/records_provider.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recordsProvider = Provider.of<RecordsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      body: ListView.builder(
        itemCount: recordsProvider.records.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(recordsProvider.records[i].imam),
          subtitle: Text(recordsProvider.records[i].topikKhutbah.isNotEmpty
              ? recordsProvider.records[i].topikKhutbah
              : 'Belum ada topik khutbah'),
          trailing: Text('${recordsProvider.records[i].jumlahJamaah} jamaah'),
        ),
      ),
    );
  }
}
