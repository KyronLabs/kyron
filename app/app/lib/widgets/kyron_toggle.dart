import 'package:flutter/material.dart';

class KyronToggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String semanticsLabel;
  
  const KyronToggle({
    super.key,
    required this.value,
    required this.onChanged,
    required this.semanticsLabel,
  });

  @override
  State<KyronToggle> createState() => _KyronToggleState();
}

class _KyronToggleState extends State<KyronToggle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      value: widget.value ? 1.0 : 0.0,
    );
    _animation = Tween<double>(begin: 0.0, end: 20.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(KyronToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      widget.value ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Semantics(
      label: widget.semanticsLabel,
      value: widget.value ? 'On' : 'Off',
      toggled: widget.value,
      child: GestureDetector(
        onTap: () => widget.onChanged(!widget.value),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: 48,
              height: 28,
              decoration: BoxDecoration(
                gradient: widget.value ? const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF8A2BE2), Color(0xFF20B2AA)], // violet → teal
                ) : null,
                color: widget.value ? null : (isDark ? const Color(0xFF333333) : const Color(0xFFD1D5DB)),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Stack(
                  children: [
                    Positioned(
                      left: _animation.value,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}