import 'package:coffee_shop_dashboard/core/helpers/colors.dart';
import 'package:coffee_shop_dashboard/modules/layouts/auth_layout.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_flex.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_responsiv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../core/helpers/mixins/ui_mixins.dart';
import '../../widgets/my_widgets/MyTextField.dart';
import '../../widgets/my_widgets/my_button.dart';
import '../../widgets/my_widgets/my_flex_item.dart';
import '../../widgets/my_widgets/my_screen_media_type.dart';
import '../../widgets/my_widgets/my_spacing.dart';
import '../../widgets/my_widgets/my_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin, UIMixin {

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: authController,
        builder: (controller){
          return MyResponsive(
            builder: (_, __, type){
              return MyFlex(
                wrapAlignment: WrapAlignment.center,
                contentPadding: false,
                children: [

                  ( type == MyScreenMediaType.sm || type == MyScreenMediaType.xs)  ?
                  MyFlexItem(child: const SizedBox()) :
                  MyFlexItem(
                    sizes: "sm-6",
                    child: Image.asset(
                      "assets/images/login_image.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),

                  MyFlexItem(
                    sizes: "sm-6",
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      child: Form(
                        key: controller.formKey,
                        child: AutofillGroup(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  margin: const EdgeInsets.only(top: 30, right: 10),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/logo.png'),
                                      fit: BoxFit.contain
                                    )
                                  ),
                                ),
                              ),
                              // child: Image.asset(adminLogo, fit: BoxFit.contain)),

                              MySpacing.height(20),

                              MyText.titleLarge(
                                "Login",
                                fontWeight: 800,
                                fontSize: 25,
                              ),

                              MySpacing.height(10),

                              MyText.bodyMedium(
                                "Enter your credentials to access\nyour account",
                              ),

                              MySpacing.height(15),

                              MyTextField(
                                  autoFillHint: const [AutofillHints.username],
                                  text: "Email",
                                  hintText: "Enter Your Email",
                                  controller: controller.email,
                                  validator: (value){
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter email';
                                    }
                                    return null;
                                  },
                                  onSubmit: (value){
                                    controller.performLogin(context);
                                    return null;
                                  },
                                  keyboardType: TextInputType.text
                              ),

                              MySpacing.height(5),

                              MyTextField(
                                autoFillHint: const [AutofillHints.password],
                                text: "Password",
                                hintText: "Enter Your Password",
                                validator:  (value){
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }else if(value.length < 6){
                                    return 'Password must have 6 digits';
                                  }
                                  return null;
                                },
                                controller: controller.password,
                                keyboardType: TextInputType.text,
                                isPassword: true,
                                onSubmit: (value){
                                  controller.performLogin(context);
                                  return null;
                                },
                              ),

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     const SizedBox.shrink(),
                              //     InkWell(
                              //       child: MyText.bodySmall(
                              //         "Forgot Password?",
                              //         color: contentTheme.primary,
                              //       ),
                              //       onTap: (){
                              //         context.beamToNamed('/admin/forgot-password');
                              //       },
                              //     ),
                              //   ],
                              // ),

                              MySpacing.height(20),

                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                                  child: Obx(()=> controller.isLoading.value ? CircularProgressIndicator(
                                    color: kPrimaryGreen,
                                  ) :
                                     MyButton.large(
                                        backgroundColor: kPrimaryGreen,
                                        onPressed: ()async{
                                          await controller.performLogin(context);
                                        },
                                        elevation: 0,
                                        padding: MySpacing.xy(20, 16),
                                        child: Center(
                                          child: MyText.bodyLarge(
                                            'Sign In',
                                            color: contentTheme.onPrimary,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                ]
              );
            }
          );
        }
      ),
    );
  }
}
