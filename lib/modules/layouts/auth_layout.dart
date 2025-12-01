import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../controllers/layout_controllers/auth_layout_controller.dart';
import '../../core/helpers/colors.dart';
import '../../widgets/my_widgets/my_card.dart';
import '../../widgets/my_widgets/my_flex.dart';
import '../../widgets/my_widgets/my_flex_item.dart';
import '../../widgets/my_widgets/my_responsiv.dart';


class AuthLayout extends StatelessWidget {
  final Widget? child;

  final AuthLayoutController controller = AuthLayoutController();

  AuthLayout({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return MyResponsive(builder: (BuildContext context, _, screenMT) {
      return GetBuilder(
          init: controller,
          builder: (controller) {
            return screenMT.isTablet || screenMT.isMobile || screenMT.isLaptop
                ? mobileScreen(context)
                : largeScreen(context);
          });
    });
  }

  Widget mobileScreen(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: colorWhite,
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: colorWhite,
        child: SingleChildScrollView(
          key: controller.scrollKey,
          child: Center(child: child),
        ),
      ),
    );
  }

  Widget largeScreen(BuildContext context) {
    return Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: Colors.grey.shade200,
        body: Stack(
          children: [
            //  Center(
            //   child: Opacity(
            //       opacity: 0.8,
            //       // child: BlurHash(hash: "LDLz?TMI00%N00I=M{%M00Rj~qRP")
            //   ),
            // ),
            Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: MyFlex(
                    wrapAlignment: WrapAlignment.center,
                    wrapCrossAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.center,
                    spacing: 0,
                    runSpacing: 0,
                    children: [
                      MyFlexItem(
                        sizes: "xxl-8 lg-8 md-9 sm-10",
                        // sizes: "xxl-3 lg-4 md-6 sm-8",
                        child: MyCard(
                          paddingAll: 0,
                          color: colorWhite,
                          child: child ?? Container(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
