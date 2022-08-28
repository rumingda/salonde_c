
import 'package:salondec/widgets/agora-group-calling/CallPage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraGroupCalling extends StatefulWidget {
  const AgoraGroupCalling({Key? key}) : super(key: key);

  @override
  _AgoraGroupCallingState createState() => _AgoraGroupCallingState();
}

class _AgoraGroupCallingState extends State<AgoraGroupCalling> {
  TextEditingController _channelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Agora Scalable UI',
                style: TextStyle(fontSize: 30),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  controller: _channelController,
                  decoration: InputDecoration(hintText: 'Channel Name'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    await [Permission.camera, Permission.microphone].request();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          VideoCallPage(channelName: _channelController.text),
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}