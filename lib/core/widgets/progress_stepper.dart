import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:resident/core/theme/app_colors.dart';
import 'package:resident/core/theme/app_spacing.dart';
import 'package:resident/core/theme/app_text_styles.dart';

class ProgressStepper extends StatefulWidget {
  const ProgressStepper({super.key});

  @override
  State<ProgressStepper> createState() => _ProgressStepperState();
}

class _ProgressStepperState extends State<ProgressStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        children: [
          _StepIndicator(step: 0, label: 'Details'),
          Expanded(child: _StepConnector(step: 0)),
          _StepIndicator(step: 1, label: 'Location'),
          Expanded(child: _StepConnector(step: 1)),
          _StepIndicator(step: 2, label: 'Units'),
          Expanded(child: _StepConnector(step: 2)),
          _StepIndicator(step: 3, label: 'Review'),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatefulWidget {
  final int step;

  final String label;
  const _StepIndicator({required this.step, required this.label});

  @override
  State<_StepIndicator> createState() => _StepIndicatorState();
}

class _StepIndicatorState extends State<_StepIndicator> {
  bool get isActive =>
      widget.step == context.watch<StepperNotifier>().currentStep;

  bool get isCompleted =>
      widget.step < context.watch<StepperNotifier>().currentStep;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.primary
                  : isActive
                  ? AppColors.primary
                  : AppColors.surfaceVariant,
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive
                    ? AppColors.primary
                    : isCompleted
                    ? AppColors.primary
                    : AppColors.border,
                width: 2,
              ),
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : Text(
                      '${widget.step + 1}',
                      style: AppTextStyles.subtitle1.copyWith(
                        color: isActive || isCompleted
                            ? Colors.white
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            widget.label,
            style: AppTextStyles.caption.copyWith(
              color: isActive
                  ? AppColors.primary
                  : isCompleted
                  ? AppColors.textPrimary
                  : AppColors.textTertiary,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _StepConnector extends StatelessWidget {
  final int step;

  const _StepConnector({required this.step});

  @override
  Widget build(BuildContext context) {
    bool isCompleted = step < context.watch<StepperNotifier>().currentStep;
    return Container(
      height: 2,
      margin: EdgeInsets.only(bottom: 28),
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.primary : AppColors.border,
      ),
    );
  }
}

class StepperNotifier extends ChangeNotifier {
  int _currentStep = 0;

  int get currentStep => _currentStep;

  void goToStep(int step) {
    _currentStep = step;
    notifyListeners();
  }

  void nextStep() {
    _currentStep++;
    notifyListeners();
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void setStep(int step) {
    _currentStep = step;
    notifyListeners();
  }
}
