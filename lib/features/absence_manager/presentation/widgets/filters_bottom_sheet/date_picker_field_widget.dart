import 'package:crewmeister_frontend_coding_challenge/core/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerFieldWidget extends StatefulWidget {
  final String label;
  final DateTime? currentDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime?) onPickedDate;
  const DatePickerFieldWidget({
    super.key,
    required this.label,
    required this.currentDate,
    required this.firstDate,
    required this.lastDate,
    required this.onPickedDate,
  });

  @override
  State<DatePickerFieldWidget> createState() => _DatePickerFieldWidgetState();
}

class _DatePickerFieldWidgetState extends State<DatePickerFieldWidget> {
  late final TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController(
        text: widget.currentDate != null
            ? DateFormat('yyyy-MM-dd').format(widget.currentDate!)
            : '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: const Icon(Icons.calendar_today),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  onPressed: _clearDate, icon: const Icon(Icons.cancel))
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onTap: _selectDate,
      );

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2100),
      currentDate: widget.currentDate,
    );

    if (pickedDate != null) {
      setState(() {
        controller.text = pickedDate.formatToYYYYmmdd;
        widget.onPickedDate(pickedDate);
      });
    }
  }

  void _clearDate() {
    setState(() {
      controller.clear();
      widget.onPickedDate(null);
    });
  }
}
