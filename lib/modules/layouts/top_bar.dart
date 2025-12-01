import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import '../../core/helpers/mixins/ui_mixins.dart';
import '../../core/helpers/theme/app_style.dart';
import '../../core/helpers/theme/app_theme.dart';
import '../../core/helpers/theme/theme_customizer.dart';
import '../../core/utils/sp_utils.dart';
import '../../widgets/my_widgets/my_button.dart';
import '../../widgets/my_widgets/my_card.dart';
import '../../widgets/my_widgets/my_container.dart';
import '../../widgets/my_widgets/my_shadow.dart';
import '../../widgets/my_widgets/my_spacing.dart';
import '../../widgets/my_widgets/my_text.dart';

class TopBar extends StatefulWidget {

  final RxBool? isLoading;

  const TopBar({
    super.key, this.isLoading
  });

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin, UIMixin {
  Function? languageHideFn;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyCard(
          shadow: MyShadow(position: MyShadowPosition.bottomRight, elevation: 0.5),
          height: 60,
          borderRadiusAll: 0,
          padding: MySpacing.x(24),
          color: topBarTheme.background.withAlpha(246),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                splashColor: theme.colorScheme.onSurface,
                highlightColor: theme.colorScheme.onSurface,
                onTap: () {
                  ThemeCustomizer.toggleLeftBarCondensed();
                },
                child: Icon(
                  LucideIcons.menu,
                  color: topBarTheme.onBackground,
                )),
              const Spacer(),
              PopupMenuButton(
                padding: EdgeInsets.zero,
                tooltip: "Logout",
                onSelected: (value) {
                    if (value == 'logout') {
                      // showDialog(
                      //   context: context,
                      //   builder: (c){
                      //     return ConfirmationDialog(
                      //       message: "You want to logout from admin panel?",
                      //       onConfirm: (){
                      //       spUtil?.clear();
                      //       Future.delayed(const Duration(milliseconds: 500), () {
                      //         Beamer.of(context).beamToNamed('/admin/login', replaceRouteInformation: true);
                      //       });
                      //       }
                      //     );
                      //   }
                      // );
                    }
                  },
                offset: const Offset(0, 50), // Controls dropdown position
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                color: Colors.grey.shade50,
                itemBuilder: (BuildContext ctx) => [
                  // PopupMenuItem<String>(
                  //   value: 'account',
                  //   child: Row(
                  //     children: [
                  //       Icon(
                  //         Icons.person,
                  //         size: 14,
                  //         color: contentTheme.dark,
                  //       ),
                  //       const SizedBox(width: 8),
                  //       MyText.labelMedium(
                  //         "My Account",
                  //         fontWeight: 700,
                  //         color: contentTheme.dark,
                  //       )
                  //     ],
                  //   ),
                  // ),

                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.log_out,
                          size: 14,
                          color: contentTheme.danger,
                        ),
                        const SizedBox(width: 8),
                        MyText.labelMedium(
                          "Log out",
                          fontWeight: 700,
                          color: contentTheme.danger,
                        )
                      ],
                    ),
                  ),
                ],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyContainer.rounded(
                        paddingAll: 0,
                        child: Image.network(
                          "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        )),
                    MySpacing.width(8),
                    // MyText.labelLarge("${spUtil?.admin.name}",fontWeight: 800,),

                    MyText.labelLarge("Admin",fontWeight: 800,),
                  ],
                ),
              ),

              // Expanded(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       MySpacing.width(12),
              //       MySpacing.width(4),
              //       CustomPopupMenu(
              //         backdrop: true,
              //         onChange: (_) {
              //           Navigator.of(context).pop();
              //         },
              //         offsetX: 60,
              //         offsetY: 8,
              //         menu: Padding(
              //           padding: MySpacing.xy(48, 8),
              //           child: Row(
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               MyContainer.rounded(
              //                   paddingAll: 0,
              //                   child: Image.network(
              //                    "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
              //                     height: 40,
              //                     width: 40,
              //                     fit: BoxFit.cover,
              //                   )),
              //               MySpacing.width(8),
              //               Column(
              //                 children: [
              //                   MyText.labelLarge("${spUtil?.user.businessName}",fontWeight: 800,),
              //                   MyText.labelLarge("${spUtil?.user.role?.name}"),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //         menuBuilder: (_) => buildAccountMenu(context),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),

        if(widget.isLoading != null)
        Obx(()=> widget.isLoading!.value ? const LinearProgressIndicator(color: Colors.red) : const SizedBox.shrink()),
      ],
    );
  }


  Widget buildAccountMenu(BuildContext ctx) {
    return MyContainer.bordered(
      paddingAll: 0,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(8, 8),
            child: MyButton(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                spUtil?.clear();
                Get.reset();
                Navigator.of(ctx).pop();
                // Beamer.of(context).beamToReplacementNamed('/onboarding');
                Beamer.of(context).beamToReplacementNamed('/admin/login');
              },
              borderRadiusAll: AppStyle.buttonRadius.medium,
              padding: MySpacing.xy(8,4),
              splashColor: contentTheme.danger.withAlpha(28),
              backgroundColor: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    LucideIcons.log_out,
                    size: 14,
                    color: contentTheme.danger,
                  ),
                  MySpacing.width(8),
                  MyText.labelMedium(
                    "Log out",
                    fontWeight: 600,
                    color: contentTheme.danger,
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
