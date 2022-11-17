import 'package:flutter/material.dart';
import 'package:fyp_project_testing/modal/medicaion.dart';
import 'package:fyp_project_testing/page/medicationCard.dart';
import 'package:fyp_project_testing/provider/medicationProvider.dart';
import 'package:provider/provider.dart';

import 'addMedicationPage.dart';

class MedicationMainPage extends StatelessWidget {
  static const routeName = "/medicationMainPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10),
      child: Column(children: [
        Row(
          children: [],
        ),
        MedicationList(),
      ]),
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

class MedicationList extends StatefulWidget {
  const MedicationList({super.key});

  @override
  State<MedicationList> createState() => _MedicationListState();
}

class _MedicationListState extends State<MedicationList> {
  var _isInit = true;
  var _isLoading = false;

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
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
    ;
  }

  @override
  Widget build(BuildContext context) {
    final medicationData =
        Provider.of<MedicationProvider>(context, listen: false).medication;
    if (medicationData.isEmpty) {
      return Container(child: Text('the list is empty'),);
    } else {
      return Expanded(child: ListView.builder(
        itemCount: medicationData.length,
        itemBuilder: (context, index) {
        return MedicationCard(
            medicationData[index].medicationName,
            medicationData[index].type,
            medicationData[index].quantity,
            medicationData[index].description,
            medicationData[index].expireDate);
      }));
    }
  }
}
