import 'package:flutter/material.dart';
import 'package:fyp_project_testing/modal/medication.dart';
import 'package:fyp_project_testing/page/medicationDetailPage.dart';
import 'package:fyp_project_testing/provider/medicationProvider.dart';
import 'package:provider/provider.dart';

class ElderlyMedicationDetailCard extends StatefulWidget {
  final id;

  ElderlyMedicationDetailCard(this.id, {super.key});

  @override
  State<ElderlyMedicationDetailCard> createState() =>
      _ElderlyMedicationDetailCardState();
}

class _ElderlyMedicationDetailCardState
    extends State<ElderlyMedicationDetailCard> {
  var _isInit = true;
  var _isLoading = false;

  List<Medication> medicatinobyID = [];

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
        Provider.of<MedicationProvider>(context, listen: false)
            .getMedicationByElderly(widget.id)
            .then((_) {
          medicatinobyID =
              Provider.of<MedicationProvider>(context, listen: false)
                  .medicationByElderlyID;
        });

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
    return _isLoading == true
        ? Container(
            child: CircularProgressIndicator(),
          )
        : Container(child: MedicationListView());
  }

  Widget MedicationListView() {
    return ListView.builder(
         padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: medicatinobyID.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 5),
            child: ListTile(
              
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Colors.green, width: 2),
              ),
              title: Text(medicatinobyID[index].medicationName),
              subtitle: Text(medicatinobyID[index].description),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        MedicationDetailPage(medicatinobyID[index].id),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
          );
        });
  }
}
