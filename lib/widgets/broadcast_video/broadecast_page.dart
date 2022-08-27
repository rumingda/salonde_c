import 'package:flutter/foundation.dart';
import 'package:salondec/data/agora_setting.dart';
import 'package:salondec/menu/Test.dart';
import 'package:salondec/widgets/broadcast_video/messaging.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:permission_handler/permission_handler.dart';
import 'package:salondec/widgets/log_sink.dart';

class BroadcastPage extends StatefulWidget {
  final String channelName;
  final String userName;
  final bool isBroadcaster;

  const BroadcastPage({Key? key, required this.channelName, required this.userName, required this.isBroadcaster}) : super(key: key);

  @override
  _BroadcastPageState createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  late final RtcEngine _engine;
  String channelId = channelName;
  bool isJoined = false;
  bool switchCamera = true;
  TextEditingController? _channelIdController;
  late TextEditingController _rtmpUrlController;
  bool _isStreaming = false;
  int _remoteUid = 0;
  bool muted = false;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk and leave channel
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: channelId);
    _rtmpUrlController = TextEditingController();
    initialize();
  }

  Future<void> initialize() async {
    // retrieve permissions

    print('브로드캐서터 역할: ${widget.isBroadcaster}');
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          '앱 아이디가 없어요. APP_ID를 넣어주세요',
        );
        _infoStrings.add('아고라 엔진이 시작되지 않았어요.');
      });
      return;
    }
    await _initAgoraRtcEngine();
  }

  Future<void> _initAgoraRtcEngine() async {
    print("허락을 요청한다");
    _engine = await RtcEngine.createWithContext(RtcEngineContext(APP_ID));
    _addAgoraEventHandlers();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
 
    //create the engine
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadcaster) {
      await _engine.setClientRole(ClientRole.Broadcaster);
    } else {
      await _engine.setClientRole(ClientRole.Audience);
    }
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        logSink.log('warning $warningCode');
      },
      error: (errorCode) {
        logSink.log('error $errorCode');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        logSink.log('joinChannelSuccess $channel $uid $elapsed');
        setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
        isJoined = true;
      });
      _startTranscoding();
    }, 
    leaveChannel: (stats) {
      logSink.log('leaveChannel ${stats.toJson()}');

      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
        isJoined = false;
      });
    }, 
    rtmpStreamingStateChanged: (String url, RtmpStreamingState state,
          RtmpStreamingErrorCode errCode) {
        logSink.log(
            'rtmpStreamingStateChanged url: $url, state: $state, errCode: $errCode');
    },
    rtmpStreamingEvent: (String url, RtmpStreamingEvent eventCode) {
        logSink.log(
            'rtmpStreamingEvent url: $url, eventCode: ${eventCode.toString()}');
    },
    userJoined: (uid, elapsed) {
      logSink.log('userJoined  $uid $elapsed');
        if (_remoteUid == 0) {
          setState(() {
            _remoteUid = uid;
          });
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    }},
    userOffline: (uid, reason) {
      logSink.log('userOffline  $uid $reason');
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
        _remoteUid = 0;
      });
    },
    firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    }));
  }

  Widget _toolbar() {
    return widget.isBroadcaster
        ? Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: _onToggleMute,
                  child: Icon(
                    muted ? Icons.mic_off : Icons.mic,
                    color: muted ? Colors.white : Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: muted ? Colors.blueAccent : Colors.white,
                  padding: const EdgeInsets.all(12.0),
                ),
                RawMaterialButton(
                  onPressed: () => _onCallEnd(context),
                  child: Icon(
                    Icons.call_end,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.redAccent,
                  padding: const EdgeInsets.all(15.0),
                ),
                RawMaterialButton(
                  onPressed: _switchCamera,
                  child: Icon(
                    Icons.switch_camera,
                    color: Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                ),
                RawMaterialButton(
                  onPressed: _goToChatPage,
                  child: Icon(
                    Icons.message_rounded,
                    color: Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                ),
              ],
            ),
          )
        : Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 48),
            child: RawMaterialButton(
              onPressed: _goToChatPage,
              child: Icon(
                Icons.message_rounded,
                color: Colors.blueAccent,
                size: 20.0,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.white,
              padding: const EdgeInsets.all(12.0),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
            _viewRows(),
            _toolbar(),
          ],
        ),
    );
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if(widget.isBroadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }

    for (var uid in _users) {
      list.add(RtcRemoteView.SurfaceView(
        channelId: widget.channelName,
        uid: uid));
    }  
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]])
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ));
      default:
    }
    return Container();
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel(APP_TOKEN, channelId, null, uid);
  }

  Future<void> _leaveChannel() async {
    if (_isStreaming) {
      await _engine.stopRtmpStream(_rtmpUrlController.text);
      _isStreaming = false;
    }

    await _engine.leaveChannel();
  }
   Future<void> _startTranscoding({bool isRemoteUser = false}) async {
    if (_isStreaming && !isRemoteUser) return;
    final streamUrl = _rtmpUrlController.text;
    if (_isStreaming && isRemoteUser) {
      await _engine.removePublishStreamUrl(streamUrl);
    }

    _isStreaming = true;

    final List<TranscodingUser> transcodingUsers = [
      TranscodingUser(
        0,
        x: 0,
        y: 0,
        width: 360,
        height: 640,
        audioChannel: AudioChannel.Channel0,
        alpha: 1.0,
      )
    ];

    int width = 360;
    int height = 640;

    if (isRemoteUser) {
      transcodingUsers.add(TranscodingUser(
        _remoteUid,
        x: 360,
        y: 0,
        width: 360,
        height: 640,
        audioChannel: AudioChannel.Channel0,
        alpha: 1.0,
      ));
      width = 720;
      height = 640;
    }
    final liveTranscoding = LiveTranscoding(
      transcodingUsers,
      width: width,
      height: height,
      videoBitrate: 400,
      videoCodecProfile: VideoCodecProfileType.High,
      videoGop: 30,
      videoFramerate: VideoFrameRate.Fps24,
      lowLatency: false,
      audioSampleRate: AudioSampleRateType.Type44100,
      audioBitrate: 48,
      audioChannels: AudioChannel.Channel1,
      audioCodecProfile: AudioCodecProfileType.LCAAC,
    );
    try {
      await _engine.startRtmpStreamWithTranscoding(streamUrl, liveTranscoding);
    } catch (e) {
      logSink.log('startRtmpStreamWithTranscoding error: ${e.toString()}');
    }
  }

  void _switchCamera() {
    _engine.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      debugPrint('switchCamera $err');
    });
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _goToChatPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RealTimeMessaging(
          channelName: widget.channelName,
          userName: widget.userName,
          isBroadcaster: widget.isBroadcaster,
        ),)
    );
  }
}