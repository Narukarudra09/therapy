import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:therapy/screens/main_screen.dart';

import '../../models/holiday.dart';
import '../../providers/super_center_provider.dart';
import '../custom_add_button.dart';

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({super.key});

  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  void addNewHoliday(SuperCenterProvider controller) {
    String newHolidayKey = 'Holiday ${controller.holidays.length + 1}';
    controller.addOrUpdateHoliday(newHolidayKey, Holiday());
  }

  void _selectDate(
      BuildContext context, SuperCenterProvider controller, String day) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green.shade400,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green.shade400,
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.green.shade400;
                }
                return null;
              }),
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

    if (picked != null) {
      controller.holidays[day]?.date = picked;
      controller.notifyListeners();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SuperCenterProvider>(context);

    // Filter out Saturday and Sunday if they are within working hours
    final filteredHolidays = controller.holidays.entries.where((entry) {
      final day = entry.key;
      final holiday = entry.value;
      if (day == 'Saturday' || day == 'Sunday') {
        final openingTime = controller.openingTimes[day];
        final closingTime = controller.closingTimes[day];
        final now = TimeOfDay.now();
        return now.isBefore(openingTime!) || now.isAfter(closingTime!);
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFBFD1E3), width: 0.3),
        ),
        title: const Text('Holidays'),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 23, 28, 34),
          height: 1.38,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Save the holidays
              controller.saveHolidays(controller.holidays);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              );
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (filteredHolidays.isEmpty)
                Center(
                  child: Text(
                    'No holidays added yet.',
                    style: GoogleFonts.inter(fontSize: 16, color: Colors.grey),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredHolidays.length,
                  itemBuilder: (context, index) {
                    String day = filteredHolidays[index].key;
                    Holiday holiday = filteredHolidays[index].value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            day,
                            style: GoogleFonts.inter(
                              color: Color(0xFF2E2C34),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Select Date',
                            style: GoogleFonts.inter(
                              color: Color(0xFF878DBA),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () => _selectDate(context, controller, day),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 232, 233, 241),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    holiday.date != null
                                        ? '${holiday.date!.toLocal()}'
                                            .split(' ')[0]
                                        : 'Select Date',
                                    style: GoogleFonts.inter(
                                      color: Color(0xFF2E2C34),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.43,
                                    ),
                                  ),
                                  const Icon(Icons.calendar_today),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Message',
                            style: GoogleFonts.inter(
                              color: Color(0xFF878DBA),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            onChanged: (value) {
                              holiday.message = value;
                              controller.notifyListeners();
                            },
                            style: GoogleFonts.inter(
                              color: Color(0xFF2E2C34),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter message',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 232, 233, 241),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 232, 233, 241),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 232, 233, 241),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              GestureDetector(
                onTap: () => addNewHoliday(controller),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 254, 254, 255),
                    border: Border.all(
                      color: const Color.fromARGB(255, 232, 233, 241),
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
