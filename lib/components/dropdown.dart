import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class CustomDropdown extends StatelessWidget {
  CustomDropdown(
      {@required this.dropdownList,
      @required this.onChanged,
      this.defaultItem});

  final List<String> dropdownList;
  final Function onChanged;
  final String defaultItem;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          onChanged(dropdownList[selectedIndex]);
        },
        children: dropdownList.map<Text>((listItem) => Text(listItem)).toList(),
        scrollController: FixedExtentScrollController(
          initialItem: dropdownList.indexOf(defaultItem),
        ),
      );
    } else {
      return DropdownButton(
        items: dropdownList
            .map<DropdownMenuItem<String>>((listItem) => DropdownMenuItem(
                  value: listItem,
                  child: Text(listItem),
                ))
            .toList(),
        onChanged: (value) {
          onChanged(value);
        },
        value: defaultItem,
      );
    }
  }
}
