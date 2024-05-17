import 'package:flutter/material.dart';
import 'package:screening_sleep_apnea/utils/app_colors.dart';

class CustomCheckboxInput extends StatefulWidget {
  final List<String> options;
  final List<String> initialValues;
  final Function(List<String>) onChanged;

  const CustomCheckboxInput({
    Key? key,
    required this.options,
    required this.initialValues,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomCheckboxInputState createState() => _CustomCheckboxInputState();
}

class _CustomCheckboxInputState extends State<CustomCheckboxInput> {
  late List<String> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues = List.from(widget.initialValues);
  }

  void _onOptionSelected(String value) {
    setState(() {
      if (_selectedValues.contains(value)) {
        _selectedValues.remove(value);
      } else {
        _selectedValues.add(value);
      }
    });
    widget.onChanged(_selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: widget.options.map((option) {
        bool isSelected = _selectedValues.contains(option);
        return GestureDetector(
          onTap: () => _onOptionSelected(option),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
