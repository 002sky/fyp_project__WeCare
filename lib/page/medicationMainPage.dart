import 'package:flutter/material.dart';
import '../drawer/appDrawer.dart';

class MedicationMainPage extends StatelessWidget {
  static const routeName = "/medicationMainPage";
  @override
  Widget build(BuildContext context) {
    return Container(

      alignment: Alignment.topCenter,
      child: DataTable(
        
        columns: const <DataColumn>[
          DataColumn(label: Text('Medication Name')),
          DataColumn(label: Text('Expire Date')),
        ],
        rows: [
          DataRow(cells: <DataCell>[
            
            DataCell(Text('Med1')),
            DataCell(Text('8-9-2022')),
            
          ],onLongPress: ()=>print('press heelo')),
          DataRow(cells: <DataCell>[
            DataCell(Text('Medication 2')),
            DataCell(Text('11-6-2023')),
        
          ]),
          DataRow(cells: <DataCell>[
            DataCell(Text('Medication 3')),
            DataCell(Text('1-10-2022')),
       
          ]),
        ],
      ),
    );
  }
}
