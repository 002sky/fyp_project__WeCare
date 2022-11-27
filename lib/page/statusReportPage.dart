import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


void showLayoutGuidelines() {
  debugPaintSizeEnabled = true;
}

class StatusReportPage extends StatelessWidget {
  // List<Report> StatusReport = dummy_report.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                              '1',
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
                              '1',
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
                              '2',
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
