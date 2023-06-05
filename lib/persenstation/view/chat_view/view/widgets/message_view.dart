import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kit_chat_app/domain/models/message_model.dart';

class MessageView extends StatefulWidget {
  const MessageView({
    Key? key,
    required this.message,
    required this.isMe,
    required this.friendImage,
    this.onTap,
  }) : super(key: key);

  final Function(String url)? onTap;
  final Message message;
  final bool isMe;
  final String friendImage;

  @override
  MessageViewState createState() => MessageViewState();
}

class MessageViewState extends State<MessageView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        margin: EdgeInsets.symmetric(vertical: 4.0.w),
        child: Align(
          alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: _buildMessageBody(),
        ),
      ),
    );
  }

  Widget _buildMessageBody() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      textDirection: widget.isMe ? TextDirection.rtl : TextDirection.ltr,
      children: [
        _buildAvatar(),
        SizedBox(width: 4.0.w),
        _buildMessageContainer(),
      ],
    );
  }

  Widget _buildAvatar() {
    return widget.isMe
        ? Icon(
            Icons.account_circle,
            size: 22.r,
            color: Colors.grey,
          )
        : CircleAvatar(
            radius: 10.r,
            backgroundImage: CachedNetworkImageProvider(widget.friendImage),
          );
  }

  Widget _buildMessageContainer() {
    return Container(
      constraints: BoxConstraints(maxWidth: 0.7.sw),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: widget.message.type == MessageType.image
            ? Colors.transparent
            : widget.isMe
                ? Colors.blue
                : Colors.grey,
        borderRadius: widget.isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(16.0.r),
                topLeft: Radius.circular(16.0.r),
                bottomRight: Radius.circular(16.0.r),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.message.type == MessageType.text) _buildTextMessage(),
          if (widget.message.type == MessageType.image) _buildImageMessage(),
          SizedBox(height: 4.0.h),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: isExpanded ? _buildTimestamp() : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextMessage() {
    return Text(
      widget.message.content,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
      ),
    );
  }

  Widget _buildImageMessage() {
    final urls = widget.message.content.replaceAll("\"", "");
    List<String> imageUrlList = urls.split(", ").toList();

    int crossAxisCount = imageUrlList.length == 1
        ? 1
        : imageUrlList.length >= 3
            ? 3
            : 2;

    final double height = heightStretch(imageUrlList.length);

    return SizedBox(
      height: height,
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 2.w,
        crossAxisSpacing: 2.w,
        childAspectRatio: 1,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(imageUrlList.length, (index) {
          String imageUrl = imageUrlList[index];
          return GestureDetector(
            onTap: () => widget.onTap?.call(imageUrl),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTimestamp() {
    return Text(
      '${widget.message.timestamp}',
      style: TextStyle(
        color: widget.message.type == MessageType.text
            ? Colors.white.withOpacity(0.5)
            : const Color.fromARGB(255, 68, 65, 65).withOpacity(0.8),
        fontSize: 12.sp,
      ),
      maxLines: isExpanded ? null : 1,
      overflow: isExpanded ? null : TextOverflow.ellipsis,
    );
  }

  double heightStretch(int length) {
    if (length == 1) {
      return 250.0.h;
    } else if (length == 2) {
      return 120.0.h;
    } else if (length == 3) {
      return 80.0.h;
    } else {
      int size = (length / 3).ceil();
      return ((size) * 80.0).h;
    }
  }
}
