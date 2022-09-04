import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salondec/menu/Test.dart';
import 'package:salondec/menu/lobby_list.dart';
import 'package:salondec/menu/myProfile.dart';
import 'package:salondec/page/viewmodel/auth_viewmodel.dart';
import 'package:salondec/widgets/agora-group-calling/GroupCallPage.dart';
import 'package:salondec/widgets/broadcast_audio/broadAudioScreen.dart';
import 'package:salondec/widgets/broadcast_video/broadVideoScreen.dart';
import 'package:salondec/widgets/join_channel_video.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({
    Key? key,
    // required TextEditingController username,
  }) : super(key: key);

  // final TextEditingController _username;
  final AuthViewModel _authViewModel = Get.find<AuthViewModel>();
  String? _username = '';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text("header"),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
            ),
            title: const Text('나의 프로필'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyProfileScreen()));
            },
          ),

          // ListTile(
          //   leading: const Icon(
          //     Icons.home,
          //   ),
          //   title: const Text('음성채팅리스트'),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) =>
          //                 // LobbyList(username: _username.text ?? "")));
          //                 LobbyList(username: _username ?? "")));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.home,
          //   ),
          //   title: const Text('테스트'),
          //   onTap: () {
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => Test()));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.home,
          //   ),
          //   title: const Text('브로드캐스트'),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => BroadcastVideo(
          //                 username: _authViewModel.user!.email!)));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.home,
          //   ),
          //   title: const Text('오디오브로드캐스트'),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => BroadcastAudio()));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.home,
          //   ),
          //   title: const Text('그룹콜'),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => AgoraGroupCalling()));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.home,
          //   ),
          //   title: const Text('아고라정식그룹콜'),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => RtmpStreaming()));
          //   },
          // ),

        ],
      ),
    );
  }
}
