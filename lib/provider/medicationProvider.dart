import 'package:flutter/cupertino.dart';
import 'package:fyp_project_testing/provider/medicationUtility.dart';
import 'package:http/http.dart';
import '../modal/medication.dart';

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

  Future<Map<String, dynamic>?> setMedication(String data) {
    Future<Map<String, dynamic>?> success = setMedicationData(data);

    getMedicationData();

    return success;
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

  Future<void> getMedicationByElderly(String id) async {
    List<Medication>? loadedMedicationByID = [];

    _isloading = true;

    if (medication.isNotEmpty) {
      try {
        var Findid = medication.where((element) => element.elderlyID == id);
        if (Findid.isNotEmpty) {
          loadedMedicationByID = Findid.toList();
          _MedicationByID = loadedMedicationByID;
        }
      } catch (e) {
        print(e);
      }
    }
    _isloading = false;

    
  }
}
