import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'triangle_painter.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const MessageBubble({
    super.key,
    required this.message,
    this.isCurrentUser = true,
  });

  MainAxisAlignment get mainAxisAlignment =>
      isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start;

  BorderRadius get borderRadius => isCurrentUser
      ? const BorderRadius.only(
          topLeft: Radius.circular(18),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        )
      : const BorderRadius.only(
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        );

  Color get backgroundColor =>
      isCurrentUser ? Colors.grey.shade900 : Colors.grey.shade300;

  Color get colorColor => isCurrentUser ? Colors.white : Colors.black;

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser)
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: CustomPaint(
                painter: Triangle(
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: borderRadius,
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: colorColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (isCurrentUser)
            CustomPaint(
              painter: Triangle(
                backgroundColor: Colors.grey.shade900,
              ),
            ),
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.only(
        right: isCurrentUser ? 18 : 50,
        left: isCurrentUser ? 50 : 18,
        top: 5,
        bottom: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}
