import 'package:salondec/widgets/broadcast_video/broadecast_page.dart';
import 'package:flutter/material.dart';
import 'package:salondec/component/custom_input_field.dart';
import 'package:salondec/component/custom_form_buttom.dart';

class BroadcastVideo extends StatefulWidget {
  final String username;
  const BroadcastVideo({Key? key, required this.username}) : super(key: key);

  @override
  _BroadcastVideoState createState() => _BroadcastVideoState();
}

class _BroadcastVideoState extends State<BroadcastVideo> {
  final _channelName = TextEditingController();
  bool _isBroadcaster = false;
  String check = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            /*TextFormField(
                              controller: _username,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                hintText: 'Username',
                              ),
                            ),*/
                            Text(widget.username),
                            CustomInputField(
                              controller: _channelName,
                              labelText: '제목',
                              hintText: '무엇을 이야기하고 싶은가요?',
                              validator: (textValue) {
                                if(textValue == null || textValue.isEmpty) {
                                  return '제목을 넣어주세요';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      /*Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: SwitchListTile(
                            title: _isBroadcaster
                                ? Text('Broadcaster')
                                : Text('Audience'),
                            value: _isBroadcaster,
                            activeColor: Color.fromRGBO(45, 156, 215, 1),
                            secondary: _isBroadcaster
                                ? Icon(
                                    Icons.account_circle,
                                    color: Color.fromRGBO(45, 156, 215, 1),
                                  )
                                : Icon(Icons.account_circle),
                            onChanged: (value) {
                              setState(() {
                                _isBroadcaster = value;
                                print(_isBroadcaster);
                              });
                            }),
                      ),*/
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: CustomFormButton(innerText: '방만들기', onPressed :(){
                            if(_channelName.text.isNotEmpty){
                              onJoin();
                              print("방만들었다");
                          }
                        }
                        ),
                       ),
                      ),
                      Text(
                        check,
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> onJoin() async {
    if (_channelName.text.isEmpty) {
      setState(() {
        check = '어떤 이야기를 나누고 싶으신가요?';
      });
    } else {
      setState(() {
        check = '';
        _isBroadcaster = true;
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BroadcastPage(
            userName: widget.username,
            channelName: _channelName.text,
            isBroadcaster: _isBroadcaster,
          ),
        ),
      );
    }
  }
}