import 'package:coffee_shop_dashboard/core/helpers/colors.dart';
import 'package:coffee_shop_dashboard/modules/layouts/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/layout_controllers/layout_controller.dart';
import '../../core/helpers/theme/theme_customizer.dart';
import '../../widgets/my_widgets/my_button.dart';
import '../../widgets/my_widgets/my_container.dart';
import '../../widgets/my_widgets/my_dashed_divider.dart';
import '../../widgets/my_widgets/my_responsiv.dart';
import '../../widgets/my_widgets/my_spacing.dart';
import '../../widgets/my_widgets/my_text.dart';
import '../../widgets/my_widgets/responsive.dart';
import 'left_bar.dart';

class Layout extends StatelessWidget {

  final Widget? child;
  final RxBool? isLoading;

  final LayoutController controller = LayoutController();
  // final topBarTheme = AdminTheme.theme.topBarTheme;
  // final contentTheme = AdminTheme.theme.contentTheme;

  Layout({super.key, this.child, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return MyResponsive(builder: (BuildContext context, _, screenMT) {
      return Material(
        color: Colors.white,
        child: GetBuilder(
            init: controller,
            builder: (controller) {
              if (screenMT.isMobile || screenMT.isTablet) {
                return mobileScreen(context);
              } else {
                return largeScreen();
              }
            }),
      );
    });
  }

  Widget mobileScreen(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: const Color(0x40ede8e8),
      appBar: AppBar(
        elevation: 0,
        actions: [

          MySpacing.width(8),
          // CustomPopupMenu(
          //   backdrop: true,
          //   onChange: (_) {},
          //   offsetX: -90,
          //   offsetY: 4,
          //   menu: Padding(
          //     padding: MySpacing.xy(8, 8),
          //     child: MyContainer.rounded(
          //         paddingAll: 0,
          //         child: Image.asset(
          //           Images.onboardingImage,
          //           height: 28,
          //           width: 28,
          //           fit: BoxFit.cover,
          //         )),
          //   ),
          //   menuBuilder: (_) => buildAccountMenu(context),
          // ),
          MySpacing.width(20)
        ],
      ), // endDrawer: RightBar(),
      drawer: const LeftBar(),
      body: SingleChildScrollView(
        key: controller.scrollKey,
        child: child,
      ),
    );
  }

  Widget largeScreen() {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: const Color(0x40ede8e8),
      body: Row(
        children: [
          LeftBar(isCondensed: ThemeCustomizer.instance.leftBarCondensed),
          Expanded(
              child: Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: SingleChildScrollView(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    padding:
                        MySpacing.fromLTRB(0, 58 + flexSpacing, 0, flexSpacing),
                    key: controller.scrollKey,
                    child: child),
              ),
              Positioned(top: 0, left: 0, right: 0, child: TopBar(isLoading: isLoading)),
            ],
          )),
        ],
      ),
    );
  }

  Widget buildNotifications() {
    Widget buildNotification(String title, String description) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.labelLarge(title),
          MySpacing.height(4),
          MyText.bodySmall(description)
        ],
      );
    }

    return MyContainer.bordered(
      paddingAll: 0,
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(16, 12),
            child: MyText.titleMedium("Notification", fontWeight: 600),
          ),
          MyDashedDivider(
              height: 1, color: colorLightGrey, dashSpace: 4, dashWidth: 6),
          Padding(
            padding: MySpacing.xy(16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildNotification("Your order is received",
                    "Order #1232 is ready to deliver"),
                MySpacing.height(12),
                buildNotification("Account Security ",
                    "Your account password changed 1 hour ago"),
              ],
            ),
          ),
          MyDashedDivider(
              height: 1, color: colorLightGrey, dashSpace: 4, dashWidth: 6),
          Padding(
            padding: MySpacing.xy(16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton.text(
                  onPressed: () {},
                  splashColor: kPrimaryGreen.withAlpha(28),
                  child: MyText.labelSmall(
                    "View All",
                    color: kPrimaryGreen,
                  ),
                ),
                MyButton.text(
                  onPressed: () {},
                  splashColor: colorRed.withAlpha(28),
                  child: MyText.labelSmall(
                    "Clear",
                    color: colorRed,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildAccountMenu(BuildContext context) {
    return MyContainer.bordered(
      paddingAll: 0,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MySpacing.height(4),
                MyButton(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () => {},
                  borderRadiusAll: 10,
                  padding: MySpacing.xy(8, 4),
                  splashColor: colorWhite.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        size: 14,
                        color: colorRed,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium(
                        "Settings",
                        fontWeight: 600,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: MySpacing.xy(8, 8),
            child: MyButton(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: (){
                // spUtil?.clear();
                // Get.reset();
                // Beamer.of(context).beamToReplacementNamed('/onboarding');
                // Beamer.of(context).beamToReplacementNamed('/auth/login');
                // Navigator.pop(context);
              },
              borderRadiusAll: 10,
              padding: MySpacing.xy(8, 4),
              splashColor: colorRed.withAlpha(28),
              backgroundColor: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    size: 14,
                    color: colorRed,
                  ),
                  MySpacing.width(8),
                  MyText.labelMedium(
                    "Log out",
                    fontWeight: 600,
                    color: colorRed,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
