import 'package:coffee_shop_dashboard/controllers/home_controller.dart';
import 'package:coffee_shop_dashboard/main.dart';
import 'package:coffee_shop_dashboard/modules/layouts/layout.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_flex.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_flex_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/my_widgets/my_responsiv.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      isLoading: homeController.isLoading,
      child: MyResponsive(
        builder: (_, __, type) {
        return MyFlex(
          contentPadding: true,
          children: [
            MyFlexItem(
              child: Column(
                children: [

                  DashboardHeader(),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: InfoCardsRow(),
                  ),

                  RevenueAnalyticsSection(),

                ],
              )
            ),
          ],
        );
      }
    )
    );
  }
}
