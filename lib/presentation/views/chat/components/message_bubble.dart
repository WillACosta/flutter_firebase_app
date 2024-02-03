import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'triangle_painter.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isReceived;

  const MessageBubble({
    super.key,
    required this.message,
    this.isReceived = false,
  });

  MainAxisAlignment get mainAxisAlignment =>
      isReceived ? MainAxisAlignment.start : MainAxisAlignment.end;

  BorderRadius get borderRadius => isReceived
      ? const BorderRadius.only(
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        )
      : const BorderRadius.only(
          topLeft: Radius.circular(18),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        );

  Color get backgroundColor =>
      isReceived ? Colors.grey.shade300 : Colors.grey.shade900;

  Color get colorColor => isReceived ? Colors.black : Colors.white;

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isReceived)
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
          if (isReceived == false)
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
        right: isReceived ? 50 : 18,
        left: isReceived ? 18 : 50,
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
