import 'package:flutter/material.dart';
import 'package:screening_sleep_apnea/utils/app_colors.dart';

class CustomAccordion extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const CustomAccordion({super.key, required this.data});

  @override
  State<CustomAccordion> createState() => _CustomAccordionState();
}

class _CustomAccordionState extends State<CustomAccordion> {
  final List<bool> _expanded = [];

  @override
  void initState() {
    super.initState();
    _expanded.addAll(List.generate(widget.data.length, (index) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.data.map<Widget>((Map<String, dynamic> section) {
        int index = widget.data.indexOf(section);

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: AppColors.kAccent4,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: ExpansionPanelList(
              expansionCallback: (int panelIndex, bool isExpanded) {
                setState(() {
                  _expanded[index] = !isExpanded;
                });
              },
              children: [
                ExpansionPanel(
                  backgroundColor: AppColors.kAccent4,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(section['title'], style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.kAccent5),),
                    );
                  },
                  body: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: section['items'].entries.map<Widget>((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(entry.key, style: TextStyle(color: AppColors.kAccent5),),
                            Text(entry.value.toString(), style: TextStyle(color: AppColors.kAccent5),),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  isExpanded: _expanded[index],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
