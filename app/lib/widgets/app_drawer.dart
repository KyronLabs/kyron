// lib/widgets/app_drawer.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Moved enum to top-level (outside class)
enum DrawerFeedbackType { open, close, drag, edge }

class AppDrawer extends StatefulWidget {
  final Widget child;
  final Widget drawerContent;
  
  const AppDrawer({
    super.key,
    required this.child,
    required this.drawerContent, required bool enableGesture,
  });
  
  @override
  AppDrawerState createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  static const double _drawerWidth = 320.0;
  static const Duration _animationDuration = Duration(milliseconds: 300);
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
  }
  
  void openDrawer() {
    _hapticFeedback(DrawerFeedbackType.open);
    _controller.forward();
  }
  
  void closeDrawer() {
    _hapticFeedback(DrawerFeedbackType.close);
    _controller.reverse();
  }
  
  void toggleDrawer() {
    if (_controller.isDismissed) {
      openDrawer();
    } else {
      closeDrawer();
    }
  }
  
  void _hapticFeedback(DrawerFeedbackType type) {
    Future.microtask(() async {
      switch (type) {
        case DrawerFeedbackType.open:
          await Future.wait([
            HapticFeedback.lightImpact(),
            Future.delayed(const Duration(milliseconds: 10), 
                () => HapticFeedback.lightImpact()),
          ]);
          break;
        case DrawerFeedbackType.close:
          await Future.wait([
            HapticFeedback.lightImpact(),
            Future.delayed(const Duration(milliseconds: 10), 
                () => HapticFeedback.selectionClick()),
          ]);
          break;
        case DrawerFeedbackType.drag:
          HapticFeedback.selectionClick();
          break;
        case DrawerFeedbackType.edge:
          HapticFeedback.lightImpact();
          break;
      }
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  bool _canBeDragged = false;
  bool _dragStartedFromEdge = false;
  double get _minDragOpenArea => MediaQuery.of(context).size.width * 0.6;
  
  void _onDragStart(DragStartDetails details) {
    // Allow opening from 60% of screen width
    final bool isDragOpenFromLeft = _controller.isDismissed &&
        details.globalPosition.dx < _minDragOpenArea;
    
    // If drag starts from the very edge, give edge haptic
    if (_controller.isDismissed && details.globalPosition.dx < 30) {
      _dragStartedFromEdge = true;
      _hapticFeedback(DrawerFeedbackType.edge);
    } else {
      _dragStartedFromEdge = false;
    }
    
    // Allow closing from anywhere on the drawer when open
    final bool isDragCloseFromAnywhere = _controller.isCompleted;
    
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromAnywhere;
  }
  
  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / _drawerWidth;
      _controller.value += delta;
      
      // Give subtle feedback during drag at certain thresholds
      if (_controller.value > 0.3 && _controller.value < 0.31) {
        _hapticFeedback(DrawerFeedbackType.drag);
      }
    }
  }
  
  void _onDragEnd(DragEndDetails details) {
    if (_dragStartedFromEdge && _controller.value > 0.1 && _controller.value < 0.9) {
      // Edge-drag special feedback
      _hapticFeedback(DrawerFeedbackType.drag);
    }
    
    if (_controller.isDismissed || _controller.isCompleted) {
      return;
    }
    
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx / MediaQuery.of(context).size.width;
      _controller.fling(velocity: visualVelocity);
    } else if (_controller.value < 0.5) {
      closeDrawer();
    } else {
      openDrawer();
    }
  }
  
  void _onTapToClose() {
    // Special haptic for tap-to-close (slightly different feel)
    HapticFeedback.selectionClick();
    closeDrawer();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final double slideAmount = _drawerWidth * _controller.value;
          final double scaleAmount = 1.0 - (0.2 * _controller.value);
          final double borderRadiusAmount = 12.0 * _controller.value;
          
          return Stack(
            children: [
              // Drawer content
              Positioned(
                left: -_drawerWidth + slideAmount,
                top: 0,
                bottom: 0,
                width: _drawerWidth,
                child: widget.drawerContent,
              ),
              
              // Main content with blur overlay
              Transform(
                transform: Matrix4.identity()
                  ..translate(slideAmount)
                  ..scale(scaleAmount),
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(borderRadiusAmount),
                  ),
                  child: Stack(
                    children: [
                      // Main app screen
                      widget.child,
                      
                      // Tap-to-close overlay with blur
                      if (_controller.value > 0)
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: _onTapToClose,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10.0 * _controller.value,
                                sigmaY: 10.0 * _controller.value,
                              ),
                              child: Container(
                                color: Colors.black.withOpacity(0.6 * _controller.value),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}