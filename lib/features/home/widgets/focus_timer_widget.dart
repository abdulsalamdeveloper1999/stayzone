import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FocusTimerWidget extends StatefulWidget {
  final String time;
  final String status;
  final double progress;
  final VoidCallback? onTap;
  final String? activityLabel;
  final String? microCopy;
  final String? scarcityMetric;

  const FocusTimerWidget({
    super.key,
    required this.time,
    required this.status,
    required this.progress,
    this.onTap,
    this.activityLabel,
    this.microCopy,
    this.scarcityMetric,
  });

  @override
  State<FocusTimerWidget> createState() => _FocusTimerWidgetState();
}

class _FocusTimerWidgetState extends State<FocusTimerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Box breathing rhythm
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.1, end: 0.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Outer Breathing Glow (280x280)
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Container(
                    width: 160.w,
                    height: 160.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF8B3DFF,
                          ).withValues(alpha: _pulseAnimation.value),
                          blurRadius: 70,
                          spreadRadius: 15,
                        ),
                      ],
                    ),
                  );
                },
              ),
              // Timer Track (240x240)
              SizedBox(
                width: 190.w,
                height: 190.h,
                child: CircularProgressIndicator(
                  value: widget.progress,
                  strokeWidth: 12,
                  backgroundColor: const Color(0xFF231F33),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF8B3DFF),
                  ),
                ),
              ),
              // Core Timer Content (Inside Circle)
              SizedBox(
                width: 150.w, // Constrain to fit inside circle
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 40.h, // Reduced height
                      child: Center(
                        child: widget.activityLabel != null
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF8B3DFF,
                                  ).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  widget.activityLabel!.toUpperCase(),
                                  style: TextStyle(
                                    color: Color(0xFF8B3DFF),
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.1),
                                  ),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  'SESSION READY',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                      ),
                    ),

                    Icon(
                      Icons.timer_outlined,
                      color: Color(0xFF8B3DFF),
                      size: 20.sp,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.time,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      widget.status,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),
          // Auxiliary Information (Outside Circle)
          if (widget.scarcityMetric != null) ...[
            Text(
              widget.scarcityMetric!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF8B3DFF).withValues(alpha: 0.8),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 12.h),
          ],
          if (widget.microCopy != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                widget.microCopy!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12.sp,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
