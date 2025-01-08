import 'package:flutter/material.dart';

class TypingText extends StatefulWidget {
  final List<String> texts;
  final TextStyle? style;
  final Duration typingSpeed;
  final Duration pauseDuration;
  final Duration deletingSpeed;

  const TypingText({
    super.key,
    required this.texts,
    this.style,
    this.typingSpeed = const Duration(milliseconds: 100),
    this.pauseDuration = const Duration(seconds: 2),
    this.deletingSpeed = const Duration(milliseconds: 50),
  });

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  late String _currentText;
  late int _currentIndex;
  late int _currentCharIndex;
  bool _isTyping = true;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _currentText = '';
    _currentIndex = 0;
    _currentCharIndex = 0;
    _startTyping();
  }

  void _startTyping() async {
    while (mounted) {
      if (_isTyping) {
        if (_currentCharIndex < widget.texts[_currentIndex].length) {
          setState(() {
            _currentText += widget.texts[_currentIndex][_currentCharIndex];
            _currentCharIndex++;
          });
          await Future.delayed(widget.typingSpeed);
        } else {
          _isPaused = true;
          await Future.delayed(widget.pauseDuration);
          _isPaused = false;
          _isTyping = false;
        }
      } else {
        if (_currentCharIndex > 0) {
          setState(() {
            _currentText = _currentText.substring(0, _currentCharIndex - 1);
            _currentCharIndex--;
          });
          await Future.delayed(widget.deletingSpeed);
        } else {
          _isTyping = true;
          _currentIndex = (_currentIndex + 1) % widget.texts.length;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _currentText,
          style: widget.style,
        ),
        _buildCursor(),
      ],
    );
  }

  Widget _buildCursor() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: _isPaused ? 0.0 : 1.0,
      child: Text(
        '|',
        style: widget.style?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
