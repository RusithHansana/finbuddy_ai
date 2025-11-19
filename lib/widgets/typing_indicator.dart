import 'package:flutter/material.dart';
import 'package:finbuddy_ai/utils/app_theme.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppTheme.spaceXs,
          horizontal: AppTheme.spaceSm,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceMd,
          vertical: AppTheme.spaceMd - 4,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(
            AppTheme.spaceMd,
          ).copyWith(bottomLeft: const Radius.circular(4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BouncingDot(controller: _controller, delay: 0),
            const SizedBox(width: 4),
            _BouncingDot(controller: _controller, delay: 0.2),
            const SizedBox(width: 4),
            _BouncingDot(controller: _controller, delay: 0.4),
          ],
        ),
      ),
    );
  }
}

class _BouncingDot extends StatelessWidget {
  final AnimationController controller;
  final double delay;

  const _BouncingDot({required this.controller, required this.delay});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final animation = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(delay, delay + 0.4, curve: Curves.easeInOut),
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
