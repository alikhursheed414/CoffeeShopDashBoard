import 'package:beamer/beamer.dart';
import 'package:coffee_shop_dashboard/core/helpers/colors.dart';
import 'package:coffee_shop_dashboard/modules/layouts/layout.dart';
import 'package:coffee_shop_dashboard/widgets/dialogs/confirmation_dialog.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_card.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_flex.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_flex_item.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_responsiv.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_text.dart';
import 'package:flutter/material.dart';
import '../../widgets/my_widgets/my_button.dart';

class CampaignsListPage extends StatefulWidget {
  const CampaignsListPage({super.key});

  @override
  State<CampaignsListPage> createState() => _CampaignsListPageState();
}

class _CampaignsListPageState extends State<CampaignsListPage> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MyResponsive(
        builder: (_, __, type){
          return MyFlex(
            children: [
              MyFlexItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText("Campaigns", fontSize: 20, fontWeight: 700),

                        MyButton(
                          onPressed: (){
                            context.beamToNamed('/add-campaign');
                          },
                          borderRadiusAll: 10,
                          msPadding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          child: MyText("+ Create campaign", color: Colors.white,),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    MyCard(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 250,
                          columns: [
                            DataColumn(
                              label: MyText("Title", fontSize: 16, fontWeight: 700),
                            ),

                            DataColumn(
                              label: MyText("Start Date", fontSize: 16, fontWeight: 700),
                            ),

                            DataColumn(
                              label: MyText("End Date", fontSize: 16, fontWeight: 700),
                            ),

                            DataColumn(
                              label: MyText("Actions", fontSize: 16, fontWeight: 700),
                            ),
                          ],
                          rows: List.generate(10, (index){
                            return DataRow(
                              cells: [
                                DataCell(MyText("Test Campaign", fontSize: 14)),
                                DataCell(MyText("Dec 1, 2025", fontSize: 14)),
                                DataCell(MyText("Dec 15, 2025", fontSize: 14)),
                                DataCell(Row(
                                  children: [
                                    IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: kPrimaryGreen)),
                                    IconButton(onPressed: (){
                                      showDialog(
                                        context: context,
                                        builder: (c){
                                          return ConfirmationDialog(
                                            onConfirm: (){},
                                          );
                                        }
                                      );
                                    }, icon: Icon(Icons.delete, color: colorRed)),
                                  ],
                                )),
                              ]
                            );
                          }),
                          // rows: [
                          //   DataRow(
                          //     cells: [
                          //       DataCell(MyText("Test Campaign", fontSize: 14)),
                          //       DataCell(MyText("Dec 1, 2025", fontSize: 14)),
                          //       DataCell(MyText("Dec 15, 2025", fontSize: 14)),
                          //       DataCell(MyText("test", fontSize: 14)),
                          //     ]
                          //   ),
                          // ]
                        ),
                      )
                    ),

                  ],
                )
              )
            ]
          );
        }
      ),
    );
  }
}
