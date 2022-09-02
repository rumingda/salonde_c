import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salondec/component/custom_form_buttom.dart';
import 'package:salondec/component/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salondec/page/screen/voiceChatRoomMaker.dart';
import 'package:permission_handler/permission_handler.dart';

//https://github.com/AgoraIO/Agora-Flutter-SDK/tree/master/example
//https://github.com/Meherdeep/agora-dynamic-video-chat-rooms

class VoiceChatLobbyScreen extends StatefulWidget {
  final String username;
  const VoiceChatLobbyScreen({Key? key, required this.username}) : super(key: key);

  @override
  _VoiceChatLobbyScreenState createState() => _VoiceChatLobbyScreenState();
}

class _VoiceChatLobbyScreenState extends State<VoiceChatLobbyScreen> {
  final TextEditingController _username = TextEditingController();

  final _channelFieldController = TextEditingController();
  bool _validateError = false;
  final Map<String, int> _channelList = {};
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> initialize() async {
  }
  @override
  Widget build(BuildContext context) {
    return Column(children : [
      Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text( 'Join an existing channel or create your own. Call will start when there are at least 2 users in your channel',
              textAlign: TextAlign.center,
              )
              ),
              CustomInputField(
                      controller: _channelFieldController,
                      labelText: '제목',
                      hintText: '무엇을 이야기하고 싶은가요?',
                      isDense: true,
                      validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return '제목을 넣어주세요!';
                          }
                          return null;
                      },
               ),
                  const SizedBox(height: 20),
                  CustomFormButton(
                        innerText: "음성살롱 만들기",
                        onPressed: onJoin),
                  const SizedBox(height: 20),
                  ])
          ),
          Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _channelList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),elevation: 0.0,
                              child:ListTile(
                              leading: const Icon(Icons.call), 
                              title: Text(_channelList.keys.toList()[index]),
                              trailing: Text("현재인원 "+
                                      _channelList.values
                                      .toList()[index]
                                      .toString() + 
                                      ' | ' + "남은자리 " + '4'),
                              onTap: () {
                                if (_channelList.values.toList()[index] <= 4) {
                                  print("입장하기");
                                  //joinCall(_channelList.keys.toList()[index],_channelList.values.toList()[index]);
                                } else {
                                  print('방꽉찼따');
                                }
                              },
                              )
                            );
                          },
                        ),
                      ),
           ]
    );
  }


  Future<void> onJoin() async {
    setState(() {
      _channelFieldController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });

    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Voicechat_making_room(channelName:_channelFieldController.text)
        ));
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}