import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kit_chat_app/domain/models/message_model.dart';

class MessageView extends StatelessWidget {
  const MessageView(
      {Key? key,
      required this.message,
      required this.isMe,
      required this.friendImage})
      : super(key: key);

  final Message message;
  final bool isMe;
  final String friendImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe)
              CircleAvatar(
                radius: 13.r,
                backgroundImage: NetworkImage(friendImage),
              ),
            SizedBox(width: 8.0.w),
            Container(
              constraints: BoxConstraints(
                maxWidth: 0.7.sw,
              ),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isMe ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0.sp,
                    ),
                  ),
                  SizedBox(height: 4.0.h),
                  Text(
                    '${message.timestamp}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
