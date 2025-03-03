import 'package:all_meal_app/common/appbar_background.dart';
import 'package:all_meal_app/widgets/filter_bottom_sheet_model.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  void _openFilterBottomSheetModal() {
    Navigator.of(context).pop();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FilterBottomSheetModel();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          decoration: ConstantColors.gradientContainer,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextButton.icon(
                //   label: Text(
                //     'Favourite Meals',
                //     style: TextStyle(
                //       fontSize: 25,
                //     ),
                //   ),
                //   icon: Icon(Icons.favorite),
                //   onPressed: _navigateToFavouriteMealScreen,
                //   style: ButtonStyle(
                //     iconSize: WidgetStatePropertyAll(40),
                //   ),
                // ),
                TextButton.icon(
                  label: Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  icon: Icon(Icons.filter_list_alt),
                  onPressed: _openFilterBottomSheetModal,
                  style: ButtonStyle(
                    iconSize: WidgetStatePropertyAll(40),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
