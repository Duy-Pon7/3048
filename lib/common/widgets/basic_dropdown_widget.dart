import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:work_flow/core/theme/app_palette.dart';
import 'package:work_flow/core/utils/screen_util.dart';

class BasicDropdownWidget<Type> extends StatelessWidget {
  const BasicDropdownWidget({
    super.key,
    required this.items,
    required this.value,
    this.onChanged,
    this.iconData,
  });
  final Map<Type, String> items;
  final Type value;
  final void Function(Type?)? onChanged;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Type>(
        isExpanded: true,
        items: items.entries
            .map(
              (el) => DropdownMenuItem<Type>(
                value: el.key,
                child: Text(
                  el.value,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            )
            .toList(),
        value: value,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          width: double.infinity,
          height: ScreenUtil.screenHeight * 0.07,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down,
          ),
          iconSize: ScreenUtil.screenWidth * 0.06,
          iconEnabledColor: AppPalette.neutural600,
          iconDisabledColor: AppPalette.neutural600,
        ),
        dropdownStyleData: DropdownStyleData(
          offset: Offset(0, -8),
          decoration: BoxDecoration(
            color: AppPalette.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        selectedItemBuilder: (context) => items.entries
            .map(
              (el) => Row(
                children: [
                  iconData != null
                      ? Row(
                          children: [
                            Icon(
                              iconData,
                              color: AppPalette.secondary500,
                            ),
                            SizedBox(
                              width: ScreenUtil.screenWidth * 0.02,
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                  Text(
                    el.value,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
