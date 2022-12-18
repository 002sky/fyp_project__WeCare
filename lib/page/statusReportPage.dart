import 'package:flutter/material.dart';
import 'package:fyp_project_testing/provider/statusReportProvider.dart';
import 'package:provider/provider.dart';

import '../component/statusReportCard.dart';

class StatusReportPage extends StatefulWidget {
  const StatusReportPage({super.key});

  @override
  State<StatusReportPage> createState() => _StatusReportPageState();
}

class _StatusReportPageState extends State<StatusReportPage> {
  var _isInit = true;
  var _isLoading = false;

  late Map<String, dynamic> totalReport;
  late List<Map<String, dynamic>> incompleteList;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<StatusReportProvider>(context, listen: false)
          .getReportTotal()
          .then((_) {
        totalReport = Provider.of<StatusReportProvider>(context, listen: false)
            .reportTotal;

        Provider.of<StatusReportProvider>(context, listen: false)
            .getStatusReport()
            .then((_) {
          incompleteList =
              Provider.of<StatusReportProvider>(context, listen: false)
                  .reportStatus;

          if (totalReport.isEmpty) {
            totalReport = {
              'currentComplete': 0,
              'imcomplete': 0,
              'totalElderly': 0,
            };
            
          }
          setState(() {
            _isLoading = false;
          });
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.all(10),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status Report",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: 100,
                          color: Colors.green,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    totalReport['currentComplete'].toString(),
                                  ),
                                ),
                              ),
                              Text('Complete'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          color: Colors.red,
                          child: Column(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    totalReport['imcomplete'].toString(),
                                  ),
                                ),
                              ),
                              Text('Incomplete'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          color: Colors.blue,
                          child: Column(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    totalReport['totalElderly'].toString(),
                                  ),
                                ),
                              ),
                              Text('Total'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  incompleteList.isEmpty
                      ? Center(
                          child: Text(
                              'The Statue report have be written for this months'),
                        )
                      : Center(
                          child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: incompleteList.length,
                          itemBuilder: (context, index) {
                            return StatusReportCard(
                                incompleteList[index]['name'],
                                incompleteList[index]['reportStatus']
                                    .toString(),
                                incompleteList[index]['id'].toString());
                          },
                        ))
                ],
              ),
            ),
    );
  }
}
