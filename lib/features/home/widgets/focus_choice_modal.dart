import 'package:flutter/material.dart';
import '../../../core/services/sound_service.dart';

class FocusChoiceModal extends StatefulWidget {
  final Function(FocusActivity) onSelected;

  const FocusChoiceModal({super.key, required this.onSelected});

  @override
  State<FocusChoiceModal> createState() => _FocusChoiceModalState();
}

class _FocusChoiceModalState extends State<FocusChoiceModal> {
  FocusActivity? _selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF14111C),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'What are you working on?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'We\'ll play some cozy sounds to match your vibe.',
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ...FocusActivity.values.map(
            (activity) => _buildActivityCard(activity),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _selected == null
                ? null
                : () {
                    widget.onSelected(_selected!);
                    Navigator.pop(context);
                  },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              backgroundColor: const Color(0xFF8B3DFF),
              disabledBackgroundColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Start Focus Session',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(FocusActivity activity) {
    final isSelected = _selected == activity;
    return GestureDetector(
      onTap: () => setState(() => _selected = activity),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF8B3DFF).withValues(alpha: 0.1)
              : const Color(0xFF1D1B26),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF8B3DFF)
                : Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF8B3DFF).withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIconForActivity(activity),
                color: isSelected ? const Color(0xFF8B3DFF) : Colors.grey[400],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Sound: ${activity.soundLabel}',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF8B3DFF)),
          ],
        ),
      ),
    );
  }

  IconData _getIconForActivity(FocusActivity activity) {
    switch (activity) {
      case FocusActivity.homework:
        return Icons.edit_note;
      case FocusActivity.presentation:
        return Icons.slideshow;
      case FocusActivity.project:
        return Icons.code;
      case FocusActivity.leetcode:
        return Icons.psychology;
    }
  }
}
