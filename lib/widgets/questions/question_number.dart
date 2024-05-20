import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:screening_sleep_apnea/utils/app_colors.dart';

import '../../models/question.dart';

class QuestionNumber extends StatefulWidget {
  final Question question;
  final Function(dynamic) updateFormData;
  final dynamic sessionValue;
  
  const QuestionNumber({super.key, required this.question, required this.updateFormData, this.sessionValue});

  @override
  State<QuestionNumber> createState() => _QuestionNumberState();
}

class _QuestionNumberState extends State<QuestionNumber> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.sessionValue ?? widget.question.input['init'];
  }


  @override
  Widget build(BuildContext context) {
    var input = widget.question.input;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberPicker(
              minValue: input['min'], 
              maxValue: input['max'], 
              value: _currentValue, 
              onChanged: (value) => setState(() {
                _currentValue = value;
                widget.updateFormData(value);
              }),
              // textStyle: TextStyle(color: AppColors.kPrimary),
            ),
            
            Text(
              input['unit'],
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black38),
              textAlign: TextAlign.center,
            ),
          ],
        )
      ],
    );
  }
}