// import 'package:flutter/material.dart';

// class StatusReportCard extends StatelessWidget {
//   final String name;
//   final String Month;
//   final String Image;
//   StatusReportCard(this.name, this.Month, this.Image);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//         onTap: () => {},
//         leading: ConstrainedBox(
//           constraints: BoxConstraints(
//             minWidth: 50,
//             minHeight: 50,
//             maxWidth: 64,
//             maxHeight: 64,
//           ),
//           child: Image.asset(Image, fit: BoxFit.scaleDown),
//         ),
//         title: Text(name),
//         trailing: ConstrainedBox(
//           constraints: BoxConstraints(
//             minWidth: 50,
//             minHeight: 50,
//             maxWidth: 64,
//             maxHeight: 64,
//           ),
//           child: Icon(
//             Icons.edit_calendar_outlined,
//             color: Colors.blue,
//           ),
//         ),
//         shape: RoundedRectangleBorder(
//           side: BorderSide(color: Colors.black54, width: 1),
//         ),
//         subtitle: Container(
//           margin: EdgeInsets.only(top: 5),
//           padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   OutlinedButton(
//                     onPressed: () => {},
//                     child: Text(Status),
//                     style: ButtonStyle(
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(0)))),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
// }
