import 'package:flutter/material.dart';
import 'package:minhttp/minhttp.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:minhttp/models/city.dart';
import 'package:easy_localization/easy_localization.dart';

class DropDownCities extends StatelessWidget {
  const DropDownCities(
      {Key key, @required this.city, @required this.onSelected})
      : super(key: key);

  final City city;
  final Function(City) onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<City>(
      maxHeight: 350,
      label: 'app_city'.tr(),
      popupItemBuilder: _customPopupItemBuilder,
      dropdownBuilder: _customDropdownBuilder,
      dropDownButton: Icon(
        Icons.arrow_drop_down_circle_outlined,
        color: Colors.white,
      ),
      dropdownSearchDecoration: InputDecoration(
        filled: true,
        fillColor: Colors.black.withOpacity(0.12),
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      onFind: (String filter) => HttpClient.instance.getCities(filter),
      onChanged: (city) => this.onSelected(city),
      isFilteredOnline: true,
      showSearchBox: true,
      errorBuilder: (context, searchEntry, exception) => Center(
        child: Text(
          // 'Cannot retrieve cities now. Please try again later.',
          exception,
          style: TextStyle(color: Colors.red),
        ),
      ),
      mode: Mode.MENU,
      selectedItem: city,
      showSelectedItem: true,
      compareFn: (item, selectedItem) => item.id == selectedItem.id,
    );
  }

  Widget _customDropdownBuilder(
      BuildContext context, City selectedItem, String itemAsAsting) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(child: Text(selectedItem.country ?? "MM")),
        ),
      ),
      title: Text(
        selectedItem.name,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        "${selectedItem.latitude.toStringAsFixed(2)}, ${selectedItem.longitude.toStringAsFixed(2)}",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _customPopupItemBuilder(
      BuildContext context, City item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      decoration: !isSelected
          ? BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(
                horizontal: BorderSide(color: Colors.black, width: 0.25),
              ),
            )
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              color: Theme.of(context).primaryColor,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(
          item.name,
          style: TextStyle(color: !isSelected ? Colors.black : Colors.white),
        ),
        subtitle: Text(
          "${item.latitude.toStringAsFixed(2)}, ${item.longitude.toStringAsFixed(2)}",
          style: TextStyle(color: !isSelected ? Colors.grey : Colors.white),
        ),
        leading: CircleAvatar(
          child: FittedBox(child: Text(item.country ?? "")),
        ),
      ),
    );
  }
}
