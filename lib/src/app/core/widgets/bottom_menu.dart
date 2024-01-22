import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../home_core.dart';
import '../local/storagehelper.dart';
import '../values/colors.dart';

class BottomMenu extends StatelessWidget
    with StorageHelper
    implements SelectBottomMenu {
  final int? bottomMenuIndex;
  final ValueChanged<int>? onChanged;
  BottomMenu({this.bottomMenuIndex, this.onChanged});
  static SelectBottomMenu? selectBottomMenu;

  BottomNavigationBarItem getItem(
    String image,
    String title,
    int index,
    ThemeData theme,
  ) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        image,
        height: 24.0,
        width: 24.0,
        color: bottomMenuIndex == 0 ? samaColor : grayColor,
      ),
      label: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    selectBottomMenu = this;



    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 3),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0.0), topRight: Radius.circular(0.0)),
        child: BottomNavigationBar(
          key: HomeCorePage.bottomWidgetKey,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w500, height: 1.5),
          currentIndex: bottomMenuIndex!,
          onTap: (value) {
            switch (value) {
              case 0:
                onChanged!(0);
                break;

              case 1:
                onChanged!(1);
                break;
              case 2:
                onChanged!(2);
                break;
              case 3:
                onChanged!(3);
                break;
                // case 4:
                //   onChanged!(4);
                break;
            }
          },
          items: <BottomNavigationBarItem>[

            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                height: 40,
                width: 40,
                child: SvgPicture.asset(
                  'assets/images/home.svg',
                  height: 24.0,
                  width: 24.0,
                  color: bottomMenuIndex == 0 ? const Color(0xffEA8024) : Colors.grey,
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  height: 40,
                  width: 460,
                  child:
                  SvgPicture.asset(
                    'assets/images/notif.svg',
                    height: 24.0,
                    width: 24.0,
                    color: bottomMenuIndex == 1 ? const Color(0xffEA8024)  : Colors.grey,
                  ),
                ),
                label: ""
            ),
            BottomNavigationBarItem(
              icon:  Container(
                padding: const EdgeInsets.all(8),
                height: 40,
                width: 40,
                child: SvgPicture.asset(
                  'assets/images/userbottom.svg',
                  height: 24.0,
                  width: 24.0,
                  color: bottomMenuIndex == 2 ?const Color(0xffEA8024) : Colors.grey,
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
                icon:  Container(
                  padding: const EdgeInsets.all(8),
                  height: 40,
                  width: 40,
                  child: SvgPicture.asset(
                    'assets/images/Category.svg',
                    height: 24.0,
                    width: 24.0,
                    color: bottomMenuIndex == 3 ? const Color(0xffEA8024) : Colors.grey,
                  ),
                ),
                label: ""),
          ],
          selectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          unselectedIconTheme: const IconThemeData(size: 25),
          selectedIconTheme: const IconThemeData(size: 25, color: samaColor),
        ),
      ),
    );
  }

  @override
  void selectBottomMenuItem(int pos) {
    onChanged!(pos);
  }
}

class SelectBottomMenu {
  void selectBottomMenuItem(int pos) {}
}
