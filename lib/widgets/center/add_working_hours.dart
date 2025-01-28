import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_holidays.dart';

class WorkingHoursPage extends StatefulWidget {
  const WorkingHoursPage({Key? key}) : super(key: key);

  @override
  _WorkingHoursPageState createState() => _WorkingHoursPageState();
}

class _WorkingHoursPageState extends State<WorkingHoursPage> {
  final Map<String, bool> holidays = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': true,
    'Sunday': true,
  };

  final Map<String, TimeOfDay> openingTimes = {
    'Monday': TimeOfDay(hour: 00, minute: 0),
    'Tuesday': TimeOfDay(hour: 00, minute: 0),
    'Wednesday': TimeOfDay(hour: 00, minute: 0),
    'Thursday': TimeOfDay(hour: 00, minute: 0),
    'Friday': TimeOfDay(hour: 00, minute: 0),
    'Saturday': TimeOfDay(hour: 00, minute: 0),
    'Sunday': TimeOfDay(hour: 00, minute: 0),
  };

  final Map<String, TimeOfDay> closingTimes = {
    'Monday': TimeOfDay(hour: 22, minute: 0),
    'Tuesday': TimeOfDay(hour: 22, minute: 0),
    'Wednesday': TimeOfDay(hour: 22, minute: 0),
    'Thursday': TimeOfDay(hour: 22, minute: 0),
    'Friday': TimeOfDay(hour: 22, minute: 0),
    'Saturday': TimeOfDay(hour: 22, minute: 0),
    'Sunday': TimeOfDay(hour: 22, minute: 0),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Working Hours',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 23, 28, 34),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HolidayScreen()));
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
                    // Adjust max width as needed
                    child: Text(
                      "Next",
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
      body: ListView(
        padding: EdgeInsets.all(16),
        children: holidays.keys.map((day) => _buildDayRow(day)).toList(),
      ),
    );
  }

  Widget _buildDayRow(String day) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2e2c34),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Holiday',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Color(0xFF878DBA),
                    ),
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                        value: holidays[day],
                        onChanged: (bool? value) {
                          setState(() {
                            holidays[day] = value ?? false;
                          });
                        },
                        activeColor: Color(0xFF45BD6F),
                        side: BorderSide(
                          color: Color(0xFF878DBA),
                          width: 2,
                        )),
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
                        fontSize: 14,
                        color: Color(0xFF878DBA),
                      ),
                    ),
                    SizedBox(height: 4),
                    _buildTimePicker(
                      time: openingTimes[day]!,
                      onTap: holidays[day]!
                          ? null
                          : () => _selectTime(context, day, true),
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
                        fontSize: 14,
                        color: Color(0xFF878DBA),
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildTimePicker(
                      time: closingTimes[day]!,
                      onTap: holidays[day]!
                          ? null
                          : () => _selectTime(context, day, false),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker({
    required TimeOfDay time,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE8E9F1)),
          color: onTap == null ? Colors.grey[100] : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time.format(context),
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Color(0xFF2e2c34),
              ),
            ),
            Icon(
              Icons.access_time,
              size: 20,
              color: Color(0xFF171C22),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(
      BuildContext context, String day, bool isOpeningTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isOpeningTime ? openingTimes[day]! : closingTimes[day]!,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green,
            ),
            buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.green,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(
        () {
          if (isOpeningTime) {
            openingTimes[day] = picked;
          } else {
            closingTimes[day] = picked;
          }
        },
      );
    }
  }
}
