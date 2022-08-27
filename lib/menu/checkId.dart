import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salondec/widgets/login/common/custom_form_buttom.dart';

class CheckIdPage extends StatefulWidget {
  const CheckIdPage({Key? key}) : super(key: key);

  @override
  State<CheckIdPage> createState() => _CheckIdState();
}

class _CheckIdState extends State<CheckIdPage> {
  //User user = FirebaseAuth.instance.currentUser!; //problem!!!!!
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 16,
          ),
          CustomFormButton(
            innerText: '로그아웃하기',
            onPressed: _handleLogoutUser,
          ),
        ],
      ),
    );
  }

  Future _handleLogoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("로그아웃되었나요?");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그아웃 되었습니다.')),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
