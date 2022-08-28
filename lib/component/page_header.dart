import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return 
        Container(
          padding: EdgeInsets.all(50),
          width: double.infinity,
          color: const Color(0xff365859),
              child: Image.asset('assets/image/logo.png',
              height: 200,),
    );
  }
}
