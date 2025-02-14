import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../state_controllers/super_center_controller.dart';

class WorkingHoursScreen extends StatefulWidget {
  const WorkingHoursScreen({
    super.key,
  });

  @override
  _WorkingHoursScreenState createState() => _WorkingHoursScreenState();
}

class _WorkingHoursScreenState extends State<WorkingHoursScreen> {
  final SuperCenterController controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectTime(
      BuildContext context, String day, bool isOpening) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isOpening
          ? controller.openingTimes[day]!
          : controller.closingTimes[day]!,
    );
    if (picked != null) {
      setState(() {
        controller.setTime(day, picked, isOpening);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3),
        ),
        title: Text(
          'Working Hours',
          style: GoogleFonts.inter(
            color: Color(0xFF171C22),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Save the holidays
              controller.updateData({
                'holidays': controller.holidays.value,
              });
              Get.back();
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color.fromARGB(255, 65, 184, 119),
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 100),
                    child: Text(
                      "Save",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: controller.holidays.length,
        itemBuilder: (context, index) {
          final day = controller.holidays.keys.elementAt(index);
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      day,
                      style: GoogleFonts.inter(
                        color: Color(0xFF2E2C34),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Holiday',
                          style: GoogleFonts.inter(
                            color: Color(0xFF878DBA),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 8),
                        Obx(() {
                          return Checkbox(
                            value: controller.holidays[day]!,
                            activeColor: Color(0xFF4CD964),
                            onChanged: (bool? value) {
                              controller.toggleHoliday(day, value ?? false);
                            },
                          );
                        }),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Open at',
                            style: GoogleFonts.inter(
                              color: Color(0xFF878DBA),
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Obx(() {
                            return GestureDetector(
                              onTap: controller.holidays[day]!
                                  ? null
                                  : () => _selectTime(context, day, true),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                  color: controller.holidays[day]!
                                      ? Colors.grey[100]
                                      : Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.openingTimes[day]!
                                          .format(context),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Icon(Icons.access_time, color: Colors.grey),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Closes at',
                            style: GoogleFonts.inter(
                              color: Color(0xFF878DBA),
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Obx(() {
                            return GestureDetector(
                              onTap: controller.holidays[day]!
                                  ? null
                                  : () => _selectTime(context, day, false),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                  color: controller.holidays[day]!
                                      ? Colors.grey[100]
                                      : Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.closingTimes[day]!
                                          .format(context),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Icon(Icons.access_time, color: Colors.grey),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
