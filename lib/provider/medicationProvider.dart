import 'package:flutter/cupertino.dart';
import 'package:fyp_project_testing/provider/medicationUtility.dart';
import '../modal/medicaion.dart';

class MedicationProvider extends ChangeNotifier {
  List<Medication>? _medication = [];
  List<Medication>? _MedicationByID = [];

  bool _isloading = false;

  List<Medication> get medication {
    return [...?_medication];
  }

  List<Medication> get medicationByID {
    return [...?_MedicationByID];
  }

  getMedicationData() async {
    List<Medication>? loadedMedication = [];

    _isloading = true;

    loadedMedication = await fetchMedicationData();

    _isloading = false;

    _medication = loadedMedication;

    notifyListeners();
  }

  setMedication(String data) {
    _isloading = true;
    bool success = setMedication(data);
    _isloading = false;

    notifyListeners();
  }

  Future<void> getMedicationByID(String id) async {
    List<Medication>? loadedMedicationByID = [];

    _isloading = true;

    if (medication.isNotEmpty) {
      var Findid = medication.where((element) => element.id == id);

      if (Findid.isNotEmpty) {
        loadedMedicationByID = Findid.toList();
      }
    }
    _isloading = false;

    _MedicationByID = loadedMedicationByID;
  }
}
