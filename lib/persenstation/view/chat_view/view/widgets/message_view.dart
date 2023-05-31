import 'dart:convert';
import 'dart:developer';

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
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Align(
          alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!widget.isMe) _buildAvatar(),
              SizedBox(width: 8.0.w),
              Flexible(child: _buildMessageContainer()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 20,
      backgroundImage: NetworkImage(widget.friendImage),
    );
  }

  Widget _buildMessageContainer() {
    return Container(
      constraints: BoxConstraints(maxWidth: 0.7.sw),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: widget.isMe
            ? widget.message.type == MessageType.image
                ? Colors.transparent
                : Colors.green
            : Colors.grey,
        borderRadius: widget.isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(16.0),
                topLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
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
      maxLines: isExpanded ? null : 1,
      overflow: isExpanded ? null : TextOverflow.ellipsis,
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
