import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:work_flow/core/theme/app_palette.dart';

Future<DateTime?> dateTimePicker(
    {required BuildContext context,
    DateTime? currentDate,
    DateTime? firstDate,
    DateTime? lastDate}) async {
  try {
    final picked = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        animateToDisplayedMonthDate: true,
        currentDate: currentDate,
        todayTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppPalette.secondary600,
              fontWeight: FontWeight.w600,
            ),
        selectedDayTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppPalette.white,
              backgroundColor: AppPalette.secondary500,
              fontWeight: FontWeight.w600,
            ),
        daySplashColor: AppPalette.transparent,
        calendarType: CalendarDatePicker2Type.single,
        selectedDayHighlightColor: AppPalette.secondary500,
        firstDate: firstDate,
        lastDate: lastDate,
        okButton: Text(
          'Chọn',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppPalette.secondary500,
                fontWeight: FontWeight.w600,
              ),
        ),
        cancelButton: Text(
          'Hủy',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppPalette.primary500,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(16),
    );

    return picked?.first ?? DateTime.now();
  } catch (e) {
    EasyLoading.showToast(
      'Vui lòng chọn ngày',
      toastPosition: EasyLoadingToastPosition.bottom,
    );
    return null;
  }
}
