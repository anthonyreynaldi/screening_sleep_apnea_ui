import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../models/question.dart';
import '../custom_checkbox.dart';

class QuestionCheckbox extends StatefulWidget {
  final Question question;
  final Function(dynamic) updateFormData;
  final dynamic sessionValue;
  
  const QuestionCheckbox({super.key, required this.question, required this.updateFormData, this.sessionValue});

  @override
  State<QuestionCheckbox> createState() => _QuestionCheckboxState();
}

class _QuestionCheckboxState extends State<QuestionCheckbox> {
  @override
  Widget build(BuildContext context) {
    return CustomCheckboxInput(
            options: widget.question.input['options'],
            initialValues: widget.sessionValue ?? [],
            onChanged: (values) {
              widget.updateFormData(values);
              // print('Selected: $values');
            },
          );
  }
}