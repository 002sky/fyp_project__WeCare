import 'package:flutter/material.dart';
import 'package:fyp_project_testing/modal/medication.dart';
import 'package:fyp_project_testing/page/medicationCard.dart';
import 'package:fyp_project_testing/provider/medicationProvider.dart';
import 'package:provider/provider.dart';

import 'addMedicationPage.dart';

class MedicationMainPage extends StatefulWidget {
  const MedicationMainPage({super.key});

  @override
  State<MedicationMainPage> createState() => _MedicationMainPageState();
}

class _MedicationMainPageState extends State<MedicationMainPage> {
  var _isInit = true;
  var _isLoading = false;
  List<Medication> medicationData = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<MedicationProvider>(
        context,
        listen: false,
      ).getMedicationData().then((_) {
        medicationData =
            Provider.of<MedicationProvider>(context, listen: false).medication;

        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
    ;
  }

  Future<void> _handleRefresh() async {
 
      setState(() {
        _isLoading = true;
      });

      Provider.of<MedicationProvider>(
        context,
        listen: false,
      ).getMedicationData().then((_) {
        medicationData =
            Provider.of<MedicationProvider>(context, listen: false).medication;

        setState(() {
          _isLoading = false;
        });
      });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading == false
          ? RefreshIndicator(
              onRefresh: _handleRefresh,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                children: [
                  Text(
                    'Medication',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: medicationData.length,
                      itemBuilder: (context, index) {
                        return MedicationCard(
                          medicationData[index].medicationName,
                          medicationData[index].type,
                          medicationData[index].quantity,
                          medicationData[index].description,
                          medicationData[index].expireDate,
                          medicationData[index].id,
                        );
                      })
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: (() {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AddMedicationPage(),
                fullscreenDialog: true,
              ));
        }),
      ),
    );
  }
}
