import 'package:flutter/material.dart';

class MedicationCard extends StatelessWidget {
  final String medicationName;
  final String type;
  final int quantity;
  final String description;
  final DateTime expireDate;

  MedicationCard(this.medicationName, this.type, this.quantity,
      this.description, this.expireDate);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.medication,
        size: 50,
      ),
      title: Text(medicationName),
      subtitle: Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start, 
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(description),
          Row(
            children: [
              OutlinedButton(
                onPressed: () => {},
                child: Text(expireDate.year.toString()),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)))),
              ),
            ],
          )
        ]),
      ),
      trailing: Text(quantity.toString()),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black54, width: 1),
      ),
    );
  }
}
