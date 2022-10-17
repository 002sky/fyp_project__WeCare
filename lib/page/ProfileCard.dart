import 'package:flutter/material.dart';
// import 'package:fyp_project_testing/modal/profile.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String DOB;
  final String bedID;
  final String gender;
  final String desc;


  ProfileCard(this.name,this.DOB, this.bedID, this.gender, this.desc);

  IconData iconType(String gender){
    if(gender.toLowerCase() == "male"){
      return Icons.male_outlined;
    }else if(gender.toLowerCase() == "female"){
      return Icons.female_outlined;
    }else{
      return Icons.question_mark_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => {},
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 50,
            minHeight: 50,
            maxWidth: 64,
            maxHeight: 64,
          ),
          // child: Image.asset(image, fit: BoxFit.scaleDown),
          child: Text(bedID),

        ),
        title: Text(name),
        trailing: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 50,
            minHeight: 50,
            maxWidth: 64,
            maxHeight: 64,
          ),
          child: Icon(
            iconType(gender),
            color: Colors.blue,
          ),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black54, width: 1),
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Column(
            children: [
              Row(
                children: [Text(desc)],
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () => {},
                    child: Text('Medication'),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)))),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
