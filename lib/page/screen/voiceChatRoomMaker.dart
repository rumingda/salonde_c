import 'package:flutter/material.dart';
import 'package:salondec/component/custom_input_field.dart';
import 'package:salondec/component/custom_form_buttom.dart';
import 'package:salondec/component/page_heading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salondec/menu/CallPage.dart';
import 'package:salondec/data/agora_setting.dart';

class Voicechat_making_room extends StatefulWidget {
  final String username;
  const Voicechat_making_room({Key? key, required this.username}) : super(key: key);

  @override
  _Voicechat_making_roomState createState() => _Voicechat_making_roomState();
}

class _Voicechat_making_roomState extends State<Voicechat_making_room> {
  
  final _channelFieldController = TextEditingController();
  String myChannel = '';

  final Map<String, List<String>> _seniorMember = {};
  final Map<String, int> _channelList = {};

  bool muted = false;
  bool _isLogin = false;
  bool _isInChannel = false;

  int count = 1;

  int x = 0;

  AgoraRtmClient? _client ;
  AgoraRtmChannel? _channel;
  AgoraRtmChannel? _subchannel;

  @override
    void dispose() {
    _channel?.leave();
    _client?.logout();
    _client?.destroy();
    _seniorMember.clear();
    _channelList.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _createClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("음성살롱 만들기"),
      ),
      body: Column(
              children: [
                    SizedBox(height: 200),
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
                    SizedBox(height: 20),
                    CustomFormButton(
                        innerText: '음성살롱 시작하기',
                        onPressed:(){
                          _createChannels(_channelFieldController.text);
                          }
                      ),
                    SizedBox(height: 200),
                  ],
                ),
    );
  }

  Future<void> _createChannels(String channelName) async {
    setState(() {
      _channelList.putIfAbsent(channelName, () => 1);
      _seniorMember.putIfAbsent(channelName, () => [widget.username]);
      myChannel = channelName;
    });
    await _channel?.sendMessage(AgoraRtmMessage.fromText('$channelName' + ':' + '1'));
    _channelFieldController.clear();
    _subchannel = await _client?.createChannel(channelName);
    await _subchannel?.join();

    print('List of channels : $_channelList');
  }

  void _createClient() async {
    _client = await AgoraRtmClient.createInstance(APP_ID);
    _client?.onConnectionStateChanged = (int state, int reason) {
      if (state == 5) {
        _client?.logout();
        print('Logout.');
        setState(() {
          _isLogin = false;
        });
      }
    };

    String userId = widget.username;
    await _client?.login(null, userId);
    print('Login success: ' + userId);
    setState(() {
      _isLogin = true;
    });

    _client?.onMessageReceived = (AgoraRtmMessage message, String peerId) {
      print('Client message received : ${message.text}');
      var data = message.text.split(':');
      setState(() {
        _channelList.putIfAbsent(data[0], () => int.parse(data[1]));
      });
    };

    _channel = await _createChannel("Lobby");
    await _channel?.join();
    print('RTM Join channel success.');
    setState(() {
      _isInChannel = true;
    });

    _client?.onConnectionStateChanged = (int state, int reason) {
      print('Connection state changed: ' +
          state.toString() +
          ', reason: ' +
          reason.toString());
      if (state == 5) {
        _client?.logout();
        print('Logout.');
        setState(() {
          _isLogin = false;
        });
      }
    };
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  Future<void> leaveCall(String channelName, String leftUser) async {
    setState(() {
      _channelList.update(channelName, (value) => value - 1);
    });

    _seniorMember.values.forEach((element) {
      if (element.first == leftUser) {
        setState(() {
          _seniorMember.values.forEach((element) {
            element.remove(leftUser);
          });
        });
      }
    });
  }
  
  Future<AgoraRtmChannel?> _createChannel(String name) async {
    AgoraRtmChannel? channel = await _client?.createChannel(name);
    if (channel != null) {
    channel.onMemberJoined = (AgoraRtmMember member) {

      _seniorMember.values.forEach(
        (element) async {
          if (element.first == widget.username) {
            // retrieve the number of users in a channel from the _channelList
            for (int i = 0; i < _channelList.length; i++) {
              if (_channelList.keys.toList()[i] == myChannel) {
                setState(() {
                  x = _channelList.values.toList()[i];
                });
              }
            }

            String data = myChannel + ':' + x.toString();
            await _client?.sendMessageToPeer(
                member.userId, AgoraRtmMessage.fromText(data));
          }
        },
      );
    };

    channel.onMemberLeft = (AgoraRtmMember member) async {
      print("Member left: " + member.userId + ', channel: ' + member.channelId);
      await leaveCall(member.channelId, member.userId);
    };
    channel.onMessageReceived =
      (AgoraRtmMessage message, AgoraRtmMember member) async {
      print(message.text);
      var data = message.text.split(':');
      if (_channelList.keys.contains(data[0])) {
        setState(() {
          _channelList.update(data[0], (v) => int.parse(data[1]));
        });
        if (int.parse(data[1]) >= 2 && int.parse(data[1]) < 5) {
          await _handleCameraAndMic(Permission.camera);
          await _handleCameraAndMic(Permission.microphone);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CallPage(channelName: data[0], username: '',),
            ),
          );
        }
        else {
        setState(() {
          _channelList.putIfAbsent(data[0], () => int.parse(data[1]));
        });
      }
      }
      };
    }
    return channel;
  }

  Future<void> joinCall(String channelName, int numberOfPeopleInThisChannel) async {
    
    _subchannel = await _createChannel(channelName);
    await _subchannel?.join();
    setState(() {
      numberOfPeopleInThisChannel = numberOfPeopleInThisChannel + 1;
    });

    _subchannel?.getMembers().then(
          (value) => value.forEach(
            (element) {
              setState(() {
                _seniorMember.update(
                    channelName, (value) => value + [element.toString()]);
              });
            },
          ),
        );

    setState(() {
      _channelList.update(channelName, (value) => numberOfPeopleInThisChannel);
    });

    _channel?.sendMessage(AgoraRtmMessage.fromText(
        '$channelName' + ':' + '$numberOfPeopleInThisChannel'));

    if (numberOfPeopleInThisChannel >= 2 && numberOfPeopleInThisChannel < 5) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(channelName: channelName, username: widget.username),
        ),
      );
    }
  }
}
