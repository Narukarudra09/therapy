import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/holiday.dart';
import '../custom_add_button.dart';

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({super.key});

  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  final List<Holiday> holidays = [Holiday()];

  void addNewHoliday() {
    setState(() {
      holidays.add(Holiday());
    });
  }

  void _selectDate(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: holidays[index].date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green.shade400, // Selected date color
              onPrimary: Colors.white, // Selected date text color
              onSurface: Colors.black, // Calendar text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green.shade400, // Button text color
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.white,
              headerBackgroundColor: Colors.white,
              headerForegroundColor: Colors.black,
              headerHeadlineStyle: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.normal,
              ),
              weekdayStyle: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
              ),
              dayStyle: const TextStyle(
                fontSize: 16,
              ),
              todayBorder: BorderSide(
                color: Colors.green.shade400,
                width: 1,
              ),
              // Shape of the date picker dialog
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              // Shape of the selected date
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.green.shade400;
                }
                return null;
              }),
              // Shape of today's date
              todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.green.shade400;
                }
                return Colors.transparent;
              }),
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != holidays[index].date) {
      setState(() {
        holidays[index].date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Holidays'),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 23, 28, 34),
        ),
        actions: [
          Container(
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: holidays.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Holiday ${index + 1}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Select Date',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () => _selectDate(context, index),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  holidays[index].date != null
                                      ? '${holidays[index].date!.month.toString().padLeft(2, '0')}-'
                                          '${holidays[index].date!.day.toString().padLeft(2, '0')}-'
                                          '${holidays[index].date!.year.toString().substring(2)}'
                                      : 'Select Date',
                                ),
                                const Icon(Icons.calendar_today),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Message',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          onChanged: (value) {
                            holidays[index].message = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: addNewHoliday,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 254, 254, 255),
                    border: Border.all(
                      color: const Color.fromARGB(255, 224, 227, 231),
                    ),
                  ),
                  child: Center(
                    child: CustomAddButton(
                      title: "Add Holiday",
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
