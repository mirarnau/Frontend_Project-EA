import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:http/http.dart' as http;
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/agoraSettings.dart';
import 'package:flutter_tutorial/services/videocallService.dart';

import 'indexPage.dart';

class CallPage extends StatefulWidget {
   final String? channelName;

  /// non-modifiable client role of the page
  final ClientRole? role;

  /// Creates a call page with given channel name.
  const CallPage({Key? key, this.channelName, this.role}) : super(key: key);
  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  int? _remoteUid;
  late RtcEngine _engine;
  bool isJoined = false, switchCamera = true, openMicrophone = true;
  bool _isRenderSurfaceView = false;
  late String token;
  //late String token = '0060be47409c1db40c1b5bef5e0468a75dbIACkgKV3mrLsAvzmKjSSGXS69HpthkjDqIX4amt9xcxFbUO+t+gAAAAAEABGROOe6Hu4YgEAAQDne7hi';

  late TextEditingController _controller;
  
  Future<void> getToken() async {
    String response = await VideocallService.getAgoraToken(widget.channelName!);
    if (response != 'Failed to fetch the token') {
      setState(() {
        token = response;
      });
    } else {
      print(response);
    }
  }

  Future<void> initAgora() async {
    await getToken();
    _engine = await RtcEngine.create(APP_ID);
    //print(token);
    await _engine.enableAudio();
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);

    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");
          setState(() {
            isJoined = true;
          });
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await _engine.joinChannel(token, widget.channelName!, null, 0);
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.channelName);
    initAgora();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }
  

  _leaveChannel() async {
    await _engine.leaveChannel();
    setState(() {
      isJoined = false;
      openMicrophone = true;
    });
  }

  _switchCamera() async {
    if (!switchCamera) _engine.enableLocalVideo(false);

    /*setState(() {
        switchCamera = !switchCamera;
      });*/
  }

  _switchMicrophone() async {
    // await _engine.muteLocalAudioStream(!openMicrophone);
    if (!openMicrophone) _engine.enableLocalAudio(false);
    /*await _engine.enableLocalAudio(!openMicrophone).then((value) {
      _engine.disableAudio();
      /*setState(() {
        openMicrophone = !openMicrophone;
      });*/
    }).catchError((err) {
      //logSink.log('enableLocalAudio $err');
    });*/
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Video Call'),
      ),
      body: Stack(
        children: [
          Center(
             child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 100,
              height: 150,
              child: Center(
                child: isJoined
                    ? RtcLocalView.SurfaceView()
                    : CircularProgressIndicator(),
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Align(
              alignment: Alignment(0.5, 0.8),
              child: SizedBox(
                height: 50,
                width: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(255, 255, 58, 58)),
                    onPressed: _switchMicrophone,
                    child: const Icon(Icons.mic_none_outlined, size: 20)),
              ),
            ),
            SizedBox(width: 50), // give it width
            Align(
              alignment: Alignment(0.5, 0.8),
              child: SizedBox(
                height: 50,
                width: 50,
                child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: Color.fromARGB(255, 255, 58, 58),
                    onPressed: () {
                      _leaveChannel();
                      final route = MaterialPageRoute(
                          builder: (context) => VideocallPage());
                      Navigator.push(context, route);
                    },
                    mini: true,
                    child: const Icon(Icons.phone_disabled_outlined, size: 20)),
              ),
            ),
            SizedBox(width: 50), // give it width
            Align(
              alignment: Alignment(0.5, 0.8),
              child: SizedBox(
                height: 50,
                width: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: _switchCamera,
                    child: const Icon(Icons.video_camera_front_outlined,
                        size: 20)),
              ),
            ),
          ])
        ],
      ),
    );
  }

  // Display remote user's 
 Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid!,
        channelId: widget.channelName!,
      );
    } else {
      return Text(
        'Please wait for another user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}