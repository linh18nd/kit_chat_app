import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kit_chat_app/domain/models/user_model.dart';
import 'package:kit_chat_app/persenstation/app_theme/theme_export.dart';
import 'package:kit_chat_app/utils/app_math/caculate_time.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    Key? key,
    required this.onTap,
    required this.user,
    required this.lastMessage,
    required this.lastMessageAt,
  }) : super(key: key);

  final VoidCallback onTap;
  final UserModel user;
  final String lastMessage;
  final DateTime lastMessageAt;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Badge(
              backgroundColor: user.status == Status.offline
                  ? AppColors.isOffline
                  : AppColors.isOnline,
              smallSize: 12.r,
            ),
          ),
        ],
      ),
      title: Text(
        user.username,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        lastMessage,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      trailing: Text(
        AppCaculateTime().calculateRecentMessageTime(lastMessageAt),
      ),
    );
  }
}

class Badge extends StatelessWidget {
  const Badge({
    Key? key,
    required this.backgroundColor,
    required this.smallSize,
  }) : super(key: key);

  final Color backgroundColor;
  final double smallSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: smallSize,
      height: smallSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
    );
  }
}
