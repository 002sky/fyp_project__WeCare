import 'package:flutter/material.dart';
import 'package:fyp_project_testing/provider/appointmentProvider.dart';
import 'package:provider/provider.dart';

import '../modal/appointmentOverview.dart';

class AppointmentOverviewPage extends StatefulWidget {
  const AppointmentOverviewPage({super.key});

  @override
  State<AppointmentOverviewPage> createState() =>
      _AppointmentOverviewPageState();
}

class _AppointmentOverviewPageState extends State<AppointmentOverviewPage> {
  var _isInit = true;
  var _isLoading = false;

  List<AppointmentOverview> listOfOverview = [];
  String _searchTerm = '';

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<AppointmentProvider>(
        context,
        listen: false,
      ).getAppointmentOverView().then((_) {
        listOfOverview =
            Provider.of<AppointmentProvider>(context, listen: false)
                .appointmentOverviewList;

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
          title: Text('Appointment Overview'),
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
                if (itemTime.Date.contains(_searchTerm)) {
                  return Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(itemTime.Date),
                        ),
                        DataTable(
                          columns: [
                            DataColumn(label: Text('Relative')),
                            DataColumn(label: Text('Time')),
                            DataColumn(label: Text('Reason')),
                          ],
                          rows: itemTime.Aitem
                              .map(
                                (detail) => DataRow(
                                  cells: [
                                    DataCell(Text(detail.Rname)),
                                    DataCell(Text(detail.time)),
                                    DataCell(Text(detail.reason)),
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
        ));
  }
}
