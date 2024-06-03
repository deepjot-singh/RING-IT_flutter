import 'package:flutter/material.dart';

class SettingComponent extends StatelessWidget {
  final String lable;
  final String imageName;
  final bool isToggle;
  Function? callBack;

  SettingComponent(
      {required this.lable,
      required this.imageName,
      this.isToggle = false,
      this.callBack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // var navigator = lable;
        callBack!();
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // CircleAvatar(
            //   radius: 13,
            //   backgroundColor: Color.fromRGBO(242, 239, 239, 1),
            //   child: Image.asset(
            //     imageName,
            //     height: 20,
            //     width: 20,
            //   ),
            // ),
            Text(
              lable,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Spacer(),
            isToggle
                ? Transform.scale(
                    scale: 0.6,
                    child: InkWell(
                        onTap: () {},
                        child: Switch(
                          onChanged: (value) {},
                          value: true,
                          activeColor: Colors.white,
                          activeTrackColor: Colors.green,
                          inactiveThumbColor: Colors.green,
                          inactiveTrackColor: Colors.white,
                        )))
                : Container()
          ],
        ),
      ),
    );
  }
}
