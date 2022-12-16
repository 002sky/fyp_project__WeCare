import 'package:flutter/material.dart';
import 'package:fyp_project_testing/provider/statusReportProvider.dart';
import 'package:provider/provider.dart';

class StatusReportPage extends StatefulWidget {
  const StatusReportPage({super.key});

  @override
  State<StatusReportPage> createState() => _StatusReportPageState();
}

class _StatusReportPageState extends State<StatusReportPage> {
  var _isInit = true;
  var _isLoading = false;

  late Map<String, dynamic> totalReport;

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

        setState(() {
          _isLoading = false;
        });
      });
    }
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
              height: 300,
              width: 500,
              margin: EdgeInsets.all(10),
              child: Column(
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
                  // Expanded(
                  //     child: ListView.builder(
                  //   itemCount: dummy_report.length,
                  //   itemBuilder: (context, index) {
                  //     return StatusReportCard(StatusReport[index].name,
                  //         StatusReport[index].image, StatusReport[index].Status);
                  //   },
                  // ))
                ],
              ),
            ),
    );
  }
}
