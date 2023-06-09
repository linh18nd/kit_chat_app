import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

class AgoraService {
  static final RtcEngine _agoraEngine = createAgoraRtcEngine();
  Future<void> setupVoiceSDKEngine() async {
    await [Permission.microphone, Permission.camera].request();
    await [Permission.microphone].request();

    _agoraEngine.initialize(
        const RtcEngineContext(appId: '9f9698ceacf149f1ba97bd29e8b7c8d5'));
    _agoraEngine.enableVideo();

    _agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          log("Local user uid:${connection.localUid} joined the channel");
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          log("Remote user uid:$remoteUid joined the channel");
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          log("Remote user uid:$remoteUid left the channel");
        },
      ),
    );
  }

  static Future<void> join(String channelId, int userId) async {
    await _agoraEngine.startPreview();
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await _agoraEngine.joinChannel(
      token:
          '007eJxTYOg2OHt3Z9mUbRrcZyL+1zIfMLmv+Miz/8S25zH3ONq/m89XYLBMszSztEhOTUxOMzSxTDNMSrQ0T0oxsky1SDJPtkgxbW9sTGkIZGTYu/0MIyMDBIL4rAwpqbn5RgwMAC9oIsQ=',
      channelId: 'demo2',
      options: options,
      uid: userId,
    );

    _agoraEngine.adjustPlaybackSignalVolume(400);
    log('-----------------------------join channel: $channelId');
  }

  static Future<void> leaveChannel() async {
    await _agoraEngine.leaveChannel();
  }

  static void disposeAgoraRtcEngine() {
    _agoraEngine.disableAudio();
  }
}
