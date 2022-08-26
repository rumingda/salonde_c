import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import '../widgets/chat/CallPage.dart';
import 'package:salondec/widgets/login/common/custom_form_buttom.dart';
import 'package:salondec/widgets/login/common/custom_input_field.dart';

//https://github.com/Meherdeep/agora-group-calling
class LobbyPage extends StatefulWidget {
  const LobbyPage({Key? key}) : super(key: key);

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  bool _validateError = false;
  final _title = TextEditingController();
  bool _isChannelCreated = true;
  final _channelFieldController = TextEditingController();
  String myChannel = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomInputField(
                  controller: _title,
                  labelText: '제목',
                  hintText: '무엇을 이야기하고 싶은가요?',
                  validator: (textValue) {
                    if(textValue == null || textValue.isEmpty) {
                      return '제목을 넣어주세요';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                CustomFormButton(innerText: '입장하기', onPressed :(){
                  if(_title.text.isNotEmpty){
                    onJoin();
                 }}
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {

  await _handleCameraAndMic(Permission.camera);
  await _handleCameraAndMic(Permission.microphone);
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print("어덯게 됐는데?");
    print(status);
      
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(channelName: _title.text),
        )
      );
  }
}