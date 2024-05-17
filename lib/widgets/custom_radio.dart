import 'package:flutter/material.dart';
import 'package:screening_sleep_apnea/utils/app_colors.dart';

class CustomRadioInput extends StatefulWidget {
  final List<String> options;
  final String initialValue;
  final Function(String) onChanged;

  const CustomRadioInput({
    Key? key,
    required this.options,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomRadioInputState createState() => _CustomRadioInputState();
}

class _CustomRadioInputState extends State<CustomRadioInput> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  void _onOptionSelected(String value) {
    setState(() {
      _selectedValue = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.options.map((option) {
        bool isSelected = _selectedValue == option;
        return GestureDetector(
          onTap: () => _onOptionSelected(option),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.kPrimary : Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: AppColors.kPrimary),
              boxShadow: isSelected
                  ? [BoxShadow(color: AppColors.kPrimary.withOpacity(0.5), blurRadius: 10.0, spreadRadius: 1.0)]
                  : [],
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.kPrimary,
                fontSize: isSelected ? 18.0 : 16.0,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
