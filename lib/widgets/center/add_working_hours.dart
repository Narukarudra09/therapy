import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Working Hours',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle save
                Navigator.pop(context);
              },
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4CD964),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
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
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      day,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Holiday',
                          style: TextStyle(
                            color: Colors.purple.shade200,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        CupertinoSwitch(
                          value: controller.holidays[day]!,
                          activeColor: Color(0xFF4CD964),
                          onChanged: (bool value) {
                            setState(() {
                              controller.toggleHoliday(day, value);
                            });
                          },
                        ),
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
                            style: TextStyle(
                              color: Colors.purple.shade200,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          GestureDetector(
                            onTap: () => _selectTime(context, day, true),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${controller.openingTimes[day]!.format(context)}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Icon(Icons.access_time, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
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
                            style: TextStyle(
                              color: Colors.purple.shade200,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          GestureDetector(
                            onTap: () => _selectTime(context, day, false),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${controller.closingTimes[day]!.format(context)}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Icon(Icons.access_time, color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
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
