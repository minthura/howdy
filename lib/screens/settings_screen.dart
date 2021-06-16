import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:minhttp/minhttp.dart';
import 'package:minhttp/models/city.dart';
import 'package:mmc/model/app_locale.dart';
import 'package:mmc/widgets/dropdown_cities.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsScreen extends StatefulWidget {
  static const route = "/settings";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  City _selectedCity;
  TempUnit _selectedTemp;
  AppLocale _appLocale;
  @override
  Widget build(BuildContext context) {
    final onecall = Provider.of<OneCall>(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background.jpeg',
            width: double.infinity,
            // height: size.height,
            fit: BoxFit.cover,
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FutureBuilder(
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Please wait');
                    } else {
                      final city = (snapshot.data as City);
                      return DropDownCities(
                        city: city,
                        onSelected: (city) => _selectedCity = city,
                      );
                    }
                  },
                  future: Provider.of<OneCall>(context, listen: false)
                      .getPreferredCity(),
                ),
                SizedBox(
                  height: 12,
                ),
                DropdownSearch<TempUnit>(
                  maxHeight: 120,
                  label: 'app_temp_unit'.tr(),
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
                  items: [TempUnit.C, TempUnit.F],
                  dropdownBuilder: (context, selectedItem, itemAsString) =>
                      Text(
                    selectedItem == TempUnit.C
                        ? 'app_temp_c'.tr()
                        : 'app_temp_f'.tr(),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  popupItemBuilder: (context, item, isSelected) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      decoration: !isSelected
                          ? BoxDecoration(
                              color: Colors.white,
                              border: Border.symmetric(
                                horizontal: BorderSide(
                                    color: Colors.black, width: 0.25),
                              ),
                            )
                          : BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              color: Theme.of(context).primaryColor,
                            ),
                      child: ListTile(
                        title: Text(
                          item == TempUnit.C
                              ? 'app_temp_c'.tr()
                              : 'app_temp_f'.tr(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  },
                  selectedItem: onecall.getTempUnit(),
                  onChanged: (temp) => _selectedTemp = temp,
                  mode: Mode.MENU,
                  showSelectedItem: true,
                  itemAsString: (item) => item == TempUnit.C
                      ? 'app_temp_c'.tr()
                      : 'app_temp_f'.tr(),
                  compareFn: (item, selectedItem) => item == selectedItem,
                ),
                SizedBox(
                  height: 12,
                ),
                DropdownSearch<AppLocale>(
                  maxHeight: 120,
                  label: 'app_locale'.tr(),
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
                  items: [AppLocale.ENGLISH, AppLocale.MYANMAR],
                  dropdownBuilder: (context, selectedItem, itemAsString) =>
                      Text(
                    selectedItem == AppLocale.MYANMAR
                        ? 'app_my'.tr()
                        : 'app_eng'.tr(),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  popupItemBuilder: (context, item, isSelected) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      decoration: !isSelected
                          ? BoxDecoration(
                              color: Colors.white,
                              border: Border.symmetric(
                                horizontal: BorderSide(
                                    color: Colors.black, width: 0.25),
                              ),
                            )
                          : BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              color: Theme.of(context).primaryColor,
                            ),
                      child: ListTile(
                        title: Text(
                          item == AppLocale.MYANMAR
                              ? 'app_my'.tr()
                              : 'app_eng'.tr(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  },
                  selectedItem: context.locale.toString() == 'my_MM'
                      ? AppLocale.MYANMAR
                      : AppLocale.ENGLISH,
                  onChanged: (locale) => _appLocale = locale,
                  mode: Mode.MENU,
                  showSelectedItem: true,
                  itemAsString: (item) => item == AppLocale.MYANMAR
                      ? 'app_my'.tr()
                      : 'app_eng'.tr(),
                  compareFn: (item, selectedItem) => item == selectedItem,
                ),
                Spacer(),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  minWidth: double.infinity,
                  padding: EdgeInsets.all(16),
                  onPressed: () {
                    if (_selectedCity != null) {
                      Provider.of<OneCall>(context, listen: false)
                          .savePreferredCity(
                            _selectedCity.latitude,
                            _selectedCity.longitude,
                            _selectedCity.name,
                            _selectedCity.id,
                          )
                          .then(
                            (_) => Provider.of<OneCall>(
                              context,
                              listen: false,
                            ).getData(
                              (e) => null,
                            ),
                          );
                    }
                    if (_selectedTemp != null) {
                      onecall.updateUnit(_selectedTemp);
                    }
                    if (_appLocale != null) {
                      if (_appLocale == AppLocale.MYANMAR) {
                        context.locale = Locale('my', 'MM');
                      } else {
                        context.locale = Locale('en', 'US');
                      }
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    'app_save'.tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
