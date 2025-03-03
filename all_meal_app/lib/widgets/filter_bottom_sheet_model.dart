import 'package:all_meal_app/common/appbar_background.dart';
import 'package:all_meal_app/models/area_model.dart';
import 'package:all_meal_app/providers/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterBottomSheetModel extends StatefulWidget {
  const FilterBottomSheetModel({super.key});

  @override
  State<FilterBottomSheetModel> createState() => _FilterBottomSheetModelState();
}

class _FilterBottomSheetModelState extends State<FilterBottomSheetModel> {
  List<AreaModel> areas = [];
  bool isAreaLoading = true;

  late AreaModel _selectedArea;
  @override
  void initState() {
    super.initState();
    getAllFilterData();
  }

  void getAllFilterData() async {
    bool isAreasPresent =
        Provider.of<FilterProvider>(context, listen: false).isAreasPresent();

    if (!isAreasPresent) {
      await Provider.of<FilterProvider>(context, listen: false).getAllAreas();
      setState(() {
        areas = Provider.of<FilterProvider>(context, listen: false).areas;
        _selectedArea = areas[0];
        isAreaLoading = false;
      });
    } else {
      setState(() {
        areas = Provider.of<FilterProvider>(context, listen: false).areas;
        _selectedArea = areas[0];
        isAreaLoading = false;
      });
    }
  }

  List<DropdownMenuItem> getDropDownMenuItems() {
    List<DropdownMenuItem> res = [];

    if (areas.isEmpty) {
      return res;
    }

    for (final area in areas) {
      res.add(DropdownMenuItem(child: Text(area.area)));
    }

    return res;
  }

  @override
   Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: ConstantColors.gradientContainer.copyWith(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            isAreaLoading
                ? CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Choose Area: ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButton(
                        value: _selectedArea,
                        items: areas.map((area) {
                          return DropdownMenuItem(
                            value: area,
                            child: Text(area.area),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedArea = value!;
                          });
                        },
                      ),
                    ],
                  ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: Text('Apply'),
                    icon: Icon(Icons.add),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: Text('Reset'),
                    icon: Icon(Icons.remove_circle),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
