import 'package:flutter/material.dart';

class DemoStack extends StatefulWidget {
  const DemoStack({super.key});

  @override
  State<DemoStack> createState() => _DemoStackState();
}

class _DemoStackState extends State<DemoStack> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Stack(
          children: [
            RotatedBox(quarterTurns: 2,
              child: Positioned(
                  top: 2,
                  left: 3,
                  right: 3,
                  child: Image.asset("assets/images/circle.png")),
            ),
            Positioned(
                bottom: 0.5,
                left: 3,
                right: 3,
                child: Image.asset("assets/images/chickenNuggets.png",height: 250,width: 250,))
          ],
        ),
      ),
    );
  }
}
