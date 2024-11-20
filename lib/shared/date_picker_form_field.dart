import 'package:finance_tracker/theme.dart';
import 'package:flutter/material.dart';

class DatePickerFormField extends FormField<DateTime> {
  DatePickerFormField({
    super.key,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate ,
    required BuildContext context,
    super.onSaved,
    super.validator,
    InputDecoration? decoration,
    String dateFormat = 'yyyy-MM-dd',
  }) : super(
          initialValue: initialDate,
          builder: (FormFieldState<DateTime> state) {
            return GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: initialDate ?? DateTime.now(),
                  firstDate: firstDate ?? DateTime(2000),
                  lastDate: lastDate ?? DateTime(2100),
                );

                if (pickedDate != null) {
                  state.didChange(pickedDate);
                }
              },
              child: InputDecorator(
                decoration: decoration ?? InputDecoration(
                  labelText: 'Date',
                  labelStyle: TextStyle(color: AppColors.primaryTextColor),
                  errorText: state.errorText,
                ),
                child: Text(
                  state.value != null
                      ? '${state.value?.year}-${state.value?.month.toString().padLeft(2, '0')}-${state.value?.day.toString().padLeft(2, '0')}'
                      : 'Select a date',
                  style: TextStyle(
                    color: AppColors.primaryTextColor,
                  ),
                ),
              ),
            );
          },
        );
}