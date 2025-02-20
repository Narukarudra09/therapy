import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/widgets/center/add_holidays.dart';

import '../../state_controllers/super_center_provider.dart';

class WorkingHoursScreen extends StatelessWidget {
  final bool isEditing;

  const WorkingHoursScreen({super.key, this.isEditing = false});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SuperCenterProvider>(context);

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
              if (isEditing) {
                controller.updateWorkingHour({
                  'holidays': controller.holidays,
                });
                Navigator.pop(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HolidayScreen()),
                );
              }
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
                      isEditing ? "Save" : "Next",
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
        itemCount: controller.openingTimes.length,
        itemBuilder: (context, index) {
          final day = controller.openingTimes.keys.elementAt(index);
          final holiday = controller.holidays[day];
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
                        Checkbox(
                          value: holiday != null,
                          activeColor: Color(0xFF4CD964),
                          onChanged: (bool? value) {
                            controller.toggleHoliday(day, value ?? false);
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
                            style: GoogleFonts.inter(
                              color: Color(0xFF878DBA),
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          GestureDetector(
                            onTap: holiday == null
                                ? () =>
                                    _selectTime(context, day, true, controller)
                                : null,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                                color: holiday == null
                                    ? Colors.white
                                    : Colors.grey[100],
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
                            style: GoogleFonts.inter(
                              color: Color(0xFF878DBA),
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          GestureDetector(
                            onTap: holiday == null
                                ? () =>
                                    _selectTime(context, day, false, controller)
                                : null,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                                color: holiday == null
                                    ? Colors.white
                                    : Colors.grey[100],
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

  Future<void> _selectTime(BuildContext context, String day, bool isOpening,
      SuperCenterProvider controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isOpening
          ? controller.openingTimes[day]!
          : controller.closingTimes[day]!,
    );
    if (picked != null) {
      controller.setTime(day, picked, isOpening);
    }
  }
}
