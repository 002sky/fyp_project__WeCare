import 'package:flutter/material.dart';
import 'package:fyp_project_testing/modal/overview.dart';
import 'package:fyp_project_testing/provider/overviewProvider.dart';
import 'package:provider/provider.dart';

class OverViewPage extends StatefulWidget {
  const OverViewPage({super.key});

  @override
  State<OverViewPage> createState() => _OverViewPageState();
}

class _OverViewPageState extends State<OverViewPage> {
  var _isInit = true;
  var _isLoading = false;
  List<Overview> listOfOverview = [];
  String _searchTerm = '';

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<OverViewProvider>(
        context,
        listen: false,
      ).getOverView().then((_) {
        listOfOverview =
            Provider.of<OverViewProvider>(context, listen: false).overview!;

        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Overview'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Perform search action here
                setState(() {
                  _searchTerm = value;
                  print(value);
                });
              },
            ),
            SizedBox(
              height: 5,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listOfOverview.length,
              itemBuilder: (context, index1) {
                final itemTime = listOfOverview[index1];
                if (itemTime.time.contains(_searchTerm)) {
                  return Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(itemTime.time 
                          ,style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataTable(
                          columns: [
                            DataColumn(label: Text('Elderly')),
                            DataColumn(label: Text('Medication')),
                            DataColumn(label: Text('Dose')),
                          ],
                          rows: itemTime.item
                              .map(
                                (detail) => DataRow(
                                  cells: [
                                    DataCell(Text(detail.eName)),
                                    DataCell(Text(detail.MedicationName)),
                                    DataCell(Text(detail.Dose)),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ],

        )
        
        );
  }
}
