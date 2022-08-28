import 'package:salondec/data/agora_setting.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salondec/component/custom_form_buttom.dart';
import 'CallPage.dart';
//https://github.com/AgoraIO/Agora-Flutter-SDK/tree/master/example
//https://github.com/Meherdeep/agora-dynamic-video-chat-rooms
class LobbyList extends StatefulWidget {
  final String username;
  const LobbyList({Key? key, required this.username}) : super(key: key);

  @override
  _LobbyListState createState() => _LobbyListState();
}

class _LobbyListState extends State<LobbyList> {
  bool _isChannelCreated = true;
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
        title: Text('Select a channel'),
      ),
      body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                _isChannelCreated
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Join an existing channel or create your own. Call will start when there are at least 2 users in your channel',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(),
                _isChannelCreated
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_channelList.keys.toList()[index] +
                                  '    -    ' +
                                  _channelList.values
                                      .toList()[index]
                                      .toString() +
                                  '/ 4'),
                              onTap: () {
                                if (_channelList.values.toList()[index] <= 4) {
                                  print("입장하기");
                                  joinCall(_channelList.keys.toList()[index],_channelList.values.toList()[index]);
                                } else {
                                  print('방꽉찼따');
                                }
                              },
                            );
                          },
                          itemCount: _channelList.length,
                        ),
                      )
                    : Center(child: Text('Please create a channel first')),
                     TextFormField(
                          controller: _channelFieldController,
                          decoration: InputDecoration(
                            hintText: 'Channel Name',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                      ),
                      CustomFormButton(
                        innerText: "방만들기",
                        onPressed: () {
                          _createChannels(_channelFieldController.text);
                        },
                      ),
              ]
                ),
            ),
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

    print("왔다");
    _subchannel = await _createChannel(channelName);
    await _subchannel?.join();
    print("왔다2");
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
