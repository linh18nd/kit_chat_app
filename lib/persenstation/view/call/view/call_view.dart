import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kit_chat_app/persenstation/view/call/controller/call_controller.dart';

class CallPage extends GetView<CallController> {
  const CallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gọi điện'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Đang gọi cho ${controller.friend?.username ?? ''}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.joinChannel();
              },
              child: const Text('Nghe'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.endCall();
              },
              child: const Text('Kết thúc'),
            ),
          ],
        ),
      ),
    );
  }
}
