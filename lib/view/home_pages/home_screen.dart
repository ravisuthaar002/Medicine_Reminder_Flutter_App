
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder_flutter_app/res/font_size/app_font_size.dart';
import 'package:medicine_reminder_flutter_app/res/routes/routes_name.dart';
import 'package:medicine_reminder_flutter_app/view_modal/controller/home_pages/home_screen_view_modal.dart';

import '../../res/colors/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  final homeScreenVieModal = HomeScreenVieModal();




  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection(user!.uid)
        .doc("Medicine")
        .collection("pills")
        .get()
        .then((snapshot){
      homeScreenVieModal.findNextPill(snapshot);
      fetchUserName();

    });
  }

  String? _name;

  void fetchUserName() async {
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(user!.uid)
          .doc("user_data")
          .get();
        _name = userDoc['Name'];

    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMMM').format(now);



    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Profile Section
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: AppFontSize.large, color: AppColors.white),
                  ),
                  SizedBox(width: Get.width * .02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hii ${_name ?? '...'}!', style: TextStyle(fontSize: AppFontSize.medium)),
                      Text('How do you feel today?', style: TextStyle(fontSize: AppFontSize.small)),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(RoutesName.threeLineMenu);
                    },
                    icon: Icon(Icons.menu, size: AppFontSize.mediumPlus, color: AppColors.orange800),
                  ),
                ],
              ),

              SizedBox(height: Get.height * .03),
              Text(formattedDate, style: TextStyle(fontSize: AppFontSize.small)),
              Text("Your Next Pill", style: TextStyle(fontSize: AppFontSize.medium, fontWeight: FontWeight.bold)),
              SizedBox(height: Get.height * .01),
              Text(
                homeScreenVieModal.nextPillName == "" ? "Loading next pill..." : "Next Pill: ${homeScreenVieModal.nextPillName} at ${homeScreenVieModal.nextPillTime}",
                style: TextStyle(fontSize: AppFontSize.small, fontWeight: FontWeight.w600, color: AppColors.teal),
              ),

              SizedBox(height: Get.height * .05),
              Text("All Medicines", style: TextStyle(fontSize: AppFontSize.medium, fontWeight: FontWeight.bold)),

              StreamBuilder(
                stream: FirebaseFirestore.instance.collection(user!.uid).doc("Medicine").collection("pills").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No Data Found"));
                  }

                  var docs = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var doc = docs[index];
                      bool isNextPill = doc["Pill"] == homeScreenVieModal.nextPillName;

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isNextPill ? AppColors.green100 : AppColors.orange200,
                          borderRadius: BorderRadius.circular(15),
                          border: isNextPill
                              ? Border.all(color: AppColors.green, width: 2)
                              : Border.all(color: Colors.transparent),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/medicine_tablet1.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: Get.width * .05),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(doc["Pill"], style: TextStyle(fontSize: AppFontSize.smallPlus, fontWeight: FontWeight.bold)),
                                  SizedBox(height: Get.height * .005),
                                  Text("Dose: ${doc["Dose"]} - ${doc["Usage"]}", style: TextStyle(fontSize: AppFontSize.small)),
                                  Text(
                                    "Time: ${(doc["Times"] as List).join(", ")}",
                                    style: TextStyle(fontSize: AppFontSize.small),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'info') {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text("More Information"),
                                      content: Text(
                                          "Pill: ${doc["Pill"]}\nDose: ${doc["Dose"]}\nShape: ${doc["Shape"]}\nDays: ${doc["Days"]}\nUsage: ${doc["Usage"]}\nTimes: ${(doc["Times"] as List).join(", ")}"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text("Close"),
                                        )
                                      ],
                                    ),
                                  );
                                } else if (value == 'delete') {
                                  FirebaseFirestore.instance
                                      .collection(user!.uid)
                                      .doc("Medicine")
                                      .collection("pills")
                                      .doc(doc.id)
                                      .delete();
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(value: 'info', child: Text('More Information')),
                                PopupMenuItem(value: 'delete', child: Text('Delete')),
                              ],
                              icon: Icon(Icons.more_vert),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
