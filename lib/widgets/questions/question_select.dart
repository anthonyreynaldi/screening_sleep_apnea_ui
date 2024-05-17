import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utils/question.dart';
import '../custom_radio.dart';

class QuestionSelect extends StatefulWidget {
  final Question question;
  final Function(dynamic) updateFormData;
  final dynamic sessionValue;

  const QuestionSelect(
      {super.key, required this.question, required this.updateFormData, this.sessionValue});

  @override
  State<QuestionSelect> createState() => _QuestionSelectState();
}

class _QuestionSelectState extends State<QuestionSelect> {
  @override
  Widget build(BuildContext context) {
    return CustomRadioInput(
            options: widget.question.input['options'],
            initialValue: widget.sessionValue ?? '',
            onChanged: (value) {
              widget.updateFormData(value);
            },
          );
  }
}
