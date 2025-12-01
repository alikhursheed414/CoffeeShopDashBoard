import 'package:coffee_shop_dashboard/core/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/layout_controllers/auth_layout_controller.dart';
import '../../widgets/my_widgets/my_container.dart';
import '../../widgets/my_widgets/my_flex.dart';
import '../../widgets/my_widgets/my_flex_item.dart';
import '../../widgets/my_widgets/my_responsiv.dart';
import '../../widgets/my_widgets/my_spacing.dart';


class AuthLayout2 extends StatelessWidget {
  final Widget? child;

  final AuthLayoutController controller = AuthLayoutController();

  AuthLayout2({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return MyResponsive(builder: (BuildContext context, _, screenMT) {
      return GetBuilder(
          init: controller,
          builder: (controller) {
            return screenMT.isMobile ? mobileScreen(context) : largeScreen(context);
          });
    });
  }

  Widget mobileScreen(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Container(
        padding: MySpacing.top(MySpacing.safeAreaTop(context) + 20),
        height: MediaQuery.of(context).size.height,
        color: colorWhite,
        child: SingleChildScrollView(
          key: controller.scrollKey,
          child: child,
        ),
      ),
    );
  }

  Widget largeScreen(BuildContext context) {
    return Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: Colors.blue,
        body: Stack(
          children: [
            const MyContainer(
              paddingAll: 0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              margin: MySpacing.top(100),
              width: MediaQuery.of(context).size.width,
              child: MyFlex(
                wrapAlignment: WrapAlignment.center,
                wrapCrossAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.center,
                spacing: 0,
                runSpacing: 0,
                children: [
                  MyFlexItem(
                    sizes: "xxl-3 lg-4 md-6 sm-8",
                    child: MyContainer(
                      paddingAll: 0,
                      color: kPrimaryGreen,
                      child: child ?? Container(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
