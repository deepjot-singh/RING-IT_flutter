// import 'package:flutter/material.dart';
// import 'package:foodorder/app/core/appColor/appColor.dart';

// class addressTypeDropdown extends StatelessWidget {
//   const addressTypeDropdown({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 50,
//         width: double.infinity,
//       decoration: BoxDecoration(
//           border: Border.all(width: 1, color: AppColor.textFeildBdr
//               //color: AppColor.textBlackColor
//               //                   <--- border width here
//               ),
//           borderRadius: BorderRadius.circular(8),
//           color: Colors.transparent),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//           //  hint: Padding(
//           //     padding: const EdgeInsets.only(left: 15),
//           //     child: new Text(
//           //       "Select Time",
//           //       style: TextStyle(
//           //         fontSize: 15,
//           //         color:AppColor.textFeildBdr
//           //       ),
//           //     ),
//           //   ),
//             value: dropdownValue,
//             onChanged: (String? newValue) {
//               setState(() {
//                 dropdownValue = newValue!;
//                 provider.manager.addressTypeTF.text = dropdownValue;       // ADD EMAIL CONTROLLER HERE
//               });
//             },
//             items: <String>['home', 'office', 'hotel', 'other']
//                 .map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value.substring(0, 1).toUpperCase() +
//                       value.substring(1),),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }