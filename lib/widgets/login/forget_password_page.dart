import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:salondec/component/custom_input_field.dart';
import 'package:salondec/component/custom_form_buttom.dart';
import 'package:salondec/component/page_header.dart';
import 'package:salondec/component/page_heading.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {

  final _forgetPasswordFormKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const PageHeader(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _forgetPasswordFormKey,
                    child: Column(
                      children: [
                        const PageHeading(title: "비밀번호 재설정",),
                        CustomInputField(
                            controller: _email,
                            labelText: '이메일',
                            hintText: '이메일 주소',
                            isDense: true,
                            validator: (textValue) {
                              if(textValue == null || textValue.isEmpty) {
                                return '이메일이 필요합니다!';
                              }
                              if(!EmailValidator.validate(textValue)) {
                                return '유효한 이메일을 입력하세요';
                              }
                              return null;
                            }
                        ),
                        const SizedBox(height: 20,),
                        CustomFormButton(innerText: '비밀번호 새로 설정하기', onPressed: _handleForgetPassword,),
                        const SizedBox(height: 20,),
                        Container(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()))
                            },
                            child: const Text(
                              '로그인하러 가기',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff939393),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _handleForgetPassword() async {
    try{
    // forget password
    if (_forgetPasswordFormKey.currentState!.validate()) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("패스워드 재설정을 위해 메일을 보냈습니다!")),
      );
      Navigator.push(
                    context,
                    MaterialPageRoute (
                      builder : (context) => LoginPage()
                      ));
    }
    }on FirebaseAuthException catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
      );
    }
  }
}