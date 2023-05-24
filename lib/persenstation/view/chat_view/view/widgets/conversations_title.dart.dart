import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/utils/convert/app_convert.dart';

class ConversationTitle extends StatelessWidget {
  const ConversationTitle({super.key, required this.friend});
  final UserModel? friend;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(friend!.avatarUrl),
        ),
        SizedBox(width: 8.0.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                friend?.username ?? 'No name',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 12.0,
                    color: friend?.status == Status.online
                        ? Colors.green
                        : Colors.grey,
                  ),
                  SizedBox(width: 4.0.w),
                  Text(
                    AppConvert.statusToString(friend!.status),
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
