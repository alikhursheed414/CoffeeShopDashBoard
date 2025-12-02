import 'package:beamer/beamer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_dashboard/core/helpers/colors.dart';
import 'package:coffee_shop_dashboard/modules/layouts/layout.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_card.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_flex.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_flex_item.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_responsiv.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/campaign_controller/campaignControllers.dart';
import '../../widgets/my_widgets/my_button.dart';

class CampaignsListPage extends StatefulWidget {
  const CampaignsListPage({super.key});

  @override
  State<CampaignsListPage> createState() => _CampaignsListPageState();
}

class _CampaignsListPageState extends State<CampaignsListPage> {
  final campaignsController = Get.put(CampaignsFirebaseController());

  // -------------------- EDIT DIALOG FUNCTION --------------------
  void showEditCampaignDialog(BuildContext context, String docId) async {
    // Fetch campaign data first
    final data = await campaignsController.getCampaignById(docId);
    if (data == null) return;

    // Local controllers for the dialog
    final TextEditingController titleController1 =
    TextEditingController(text: data["title"] ?? "");
    final TextEditingController titleController2 =
    TextEditingController(text: data["subtitle"] ?? "");
    DateTime? startDate = DateTime.tryParse(data["startDate"] ?? "");
    DateTime? endDate = DateTime.tryParse(data["endDate"] ?? "");
    String? uploadedImageName = data["image"]?.split("/").last;

    // Helper functions
    Future<void> pickStartDate() async {
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: startDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) startDate = pickedDate;
    }

    Future<void> pickEndDate() async {
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: endDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) endDate = pickedDate;
    }

    // Show Dialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              // Date picker widget
              Widget dateBox(
                  String label, DateTime? date, Future<void> Function() onTap) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: () async {
                        await onTap();
                        setStateDialog(() {}); // Refresh dialog UI
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              date == null
                                  ? "Select date"
                                  : "${date.year}-${date.month}-${date.day}",
                              style: const TextStyle(fontSize: 14),
                            ),
                            const Spacer(),
                            const Icon(Icons.calendar_today, size: 18),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }

              return SizedBox(
                width: 600,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Edit Campaign",
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Title"),
                                const SizedBox(height: 6),
                                TextField(controller: titleController1),
                              ],
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                              child:
                              dateBox("Starting Date", startDate, pickStartDate)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Subtitle"),
                                const SizedBox(height: 6),
                                TextField(controller: titleController2),
                              ],
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(child: dateBox("End Date", endDate, pickEndDate)),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade50,
                        ),
                        child: Column(
                          children: [
                            const Text("Upload Ad Image"),
                            const SizedBox(height: 6),
                            ElevatedButton.icon(
                              onPressed: () async {
                                // handle image upload if needed
                                setStateDialog(() {}); // Refresh dialog UI
                              },
                              icon: const Icon(Icons.upload),
                              label: const Text("Upload"),
                            ),
                            if (uploadedImageName != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text("Selected: $uploadedImageName"),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          const SizedBox(width: 16),
                          Obx(() => campaignsController.isLoading.value
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                            onPressed: () async {
                              if (titleController1.text.isEmpty ||
                                  titleController2.text.isEmpty ||
                                  startDate == null ||
                                  endDate == null) {
                                Get.snackbar(
                                    "Error", "Please fill all fields");
                                return;
                              }

                              bool success =
                              await campaignsController.updateCampaign(
                                docId: docId,
                                title: titleController1.text.trim(),
                                subtitle: titleController2.text.trim(),
                                startDate: startDate!,
                                endDate: endDate!,
                              );

                              if (success) {
                                Get.snackbar(
                                    "Success", "Campaign updated successfully");
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Update"),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // -------------------- BUILD --------------------
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MyResponsive(builder: (_, __, type) {
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
                        onPressed: () {
                          context.beamToNamed('/add-campaign');
                        },
                        borderRadiusAll: 10,
                        msPadding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        child: MyText(
                          "+ Create campaign",
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  StreamBuilder<QuerySnapshot>(
                    stream: campaignsController.getCampaignsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(color: kPrimaryGreen));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("No campaigns found"));
                      }

                      final campaigns = snapshot.data!.docs;

                      return MyCard(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 250,
                            columns: [
                              DataColumn(
                                  label:
                                  MyText("Title", fontSize: 16, fontWeight: 700)),
                              DataColumn(
                                  label: MyText("Start Date",
                                      fontSize: 16, fontWeight: 700)),
                              DataColumn(
                                  label: MyText("End Date",
                                      fontSize: 16, fontWeight: 700)),
                              DataColumn(
                                  label: MyText("Actions",
                                      fontSize: 16, fontWeight: 700)),
                            ],
                            rows: campaigns.map((doc) {
                              final data = doc.data() as Map<String, dynamic>;
                              final title = data["title"] ?? "";
                              final startDateStr = data["startDate"] ?? "";
                              final endDateStr = data["endDate"] ?? "";

                              final startDate = DateTime.tryParse(startDateStr);
                              final endDate = DateTime.tryParse(endDateStr);

                              return DataRow(cells: [
                                DataCell(MyText(title, fontSize: 14)),
                                DataCell(MyText(
                                  startDate != null
                                      ? "${startDate.year}-${startDate.month}-${startDate.day}"
                                      : "",
                                  fontSize: 14,
                                )),
                                DataCell(MyText(
                                  endDate != null
                                      ? "${endDate.year}-${endDate.month}-${endDate.day}"
                                      : "",
                                  fontSize: 14,
                                )),
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showEditCampaignDialog(context, doc.id);
                                      },
                                      icon: Icon(Icons.edit, color: kPrimaryGreen),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text("Delete Campaign"),
                                              content: const Text(
                                                  "Are you sure you want to delete this campaign? This action cannot be undone."),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: colorRed),
                                                  onPressed: () {
                                                    campaignsController.deleteCampaign(doc.id);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Delete"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.delete, color: colorRed),
                                    ),
                                  ],
                                )),
                              ]);
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
