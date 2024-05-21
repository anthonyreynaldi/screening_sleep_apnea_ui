import 'package:flutter/material.dart';
import 'package:screening_sleep_apnea/widgets/custom_image.dart';
import 'package:screening_sleep_apnea/widgets/questions/question_checkbox.dart';
import 'package:screening_sleep_apnea/widgets/questions/question_number.dart';
import 'package:screening_sleep_apnea/widgets/questions/question_select.dart';

import '../../animations/onboarding_animation.dart';
import '../../models/question.dart';


class QuestionCard extends StatefulWidget {
  final bool playAnimation;
  final Question question;
  final Function(dynamic) updateFormData;
  final dynamic sessionValue;

  const QuestionCard(
      {required this.playAnimation, super.key, required this.question, required this.updateFormData, this.sessionValue});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard>
    with TickerProviderStateMixin {
  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;

  Animation<Offset> get slideAnimation => _slideAnimation;
  AnimationController get slideAnimationController => _slideAnimationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.playAnimation) {
      _slideAnimationController.forward();
    } else {
      _slideAnimationController.animateTo(
        1,
        duration: const Duration(milliseconds: 0),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _slideAnimationController =
        OnboardingAnimations.createSlideController(this);
    _slideAnimation =
        OnboardingAnimations.openSpotsSlideAnimation(_slideAnimationController);
  }

  @override
  void dispose() {
    _slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Column(
        children: [
          Expanded(
            child: CustomImage(imageUrl: widget.question.image),
          ),
          const SizedBox(height: 24),

          Text(
            widget.question.title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          Text(
            widget.question.question,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          _buildInput(widget.question.input),
        ],
      ),
    );
  }

  Widget _buildInput(Map input) {
    switch (input['type']) {
      case 'number':
        return QuestionNumber(question: widget.question, updateFormData: widget.updateFormData, sessionValue: widget.sessionValue);
      case 'select':
        return QuestionSelect(question: widget.question, updateFormData: widget.updateFormData, sessionValue: widget.sessionValue);
      case 'checkbox':
        return QuestionCheckbox(question: widget.question, updateFormData: widget.updateFormData, sessionValue: widget.sessionValue);
      default:
        return Container();
    }
  }
}