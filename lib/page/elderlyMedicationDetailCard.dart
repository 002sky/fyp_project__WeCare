import 'package:flutter/material.dart';
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
  var id;
  var _isInit = true;
  var _isLoading = false;

  var medicatinobyID = [];

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
            .getMedicationByElderly(widget.id);

        medicatinobyID = Provider.of<MedicationProvider>(context, listen: false)
            .medicationByID;
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
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
        itemCount: medicatinobyID.length,
        itemBuilder: (context, index) {
          return ListTile(
            title:Text( medicatinobyID[index].medicationName),
          );
        });
  }
}
