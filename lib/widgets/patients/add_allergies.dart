import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:therapy/widgets/custom_add_button.dart';

class AddAllergies extends StatefulWidget {
  const AddAllergies({super.key});

  @override
  State<AddAllergies> createState() => _AddAllergiesState();
}

final List<String> allergies = [
  'Cheese',
  'Curd',
  'Egg',
  'Garlic',
  'Gluten',
  'Lemon',
  'Meat',
  'Milk',
  'Nuts',
  'Oats',
  'Other Fruits',
  'Peanut',
  'Peppers',
  'Preserved Foods',
  'Shellfish/Fish',
  'Soya',
];

final List<bool> selectedAllergies = List.generate(16, (_) => false);

class _AddAllergiesState extends State<AddAllergies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Allergies"),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 23, 28, 34),
        ),
        actions: [
          Container(
            width: 74,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color.fromARGB(255, 65, 184, 119),
            ),
            child: Center(
              child: Text(
                "Save",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        contentPadding: EdgeInsets.all(0),
                        titlePadding: EdgeInsets.only(
                            left: 21, right: 21, top: 24, bottom: 15),
                        actionsAlignment: MainAxisAlignment.spaceAround,
                        insetPadding: EdgeInsets.symmetric(horizontal: 20),
                        actionsPadding: EdgeInsets.only(top: 24, bottom: 32),
                        title: Center(child: Text('Add New')),
                        titleTextStyle: GoogleFonts.sora(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        content: SizedBox(
                          width: 500,
                          height: MediaQuery.of(context).size.height * 0.119,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 24),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 232, 233, 241),
                                      ),
                                    ),
                                    hintText: 'Write Here',
                                    hintStyle: GoogleFonts.inter(
                                      color: Color.fromARGB(255, 46, 44, 52),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Divider()
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 162,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  "No",
                                  style: GoogleFonts.inter(
                                    color: Color.fromARGB(255, 118, 141, 139),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 162,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 65, 184, 119),
                              ),
                              child: Center(
                                child: Text(
                                  "Add",
                                  style: GoogleFonts.sora(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 254, 254, 255),
                      border: Border.all(
                          color: Color.fromARGB(255, 224, 227, 231))),
                  child: Center(
                    child: CustomAddButton(
                      title: "Add New",
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: allergies.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    side: BorderSide(
                        color: Color.fromARGB(255, 224, 227, 231), width: 2),
                    activeColor: Color.fromARGB(255, 65, 184, 119),
                    checkboxShape: OvalBorder(),
                    title: Text(allergies[index]),
                    value: selectedAllergies[index],
                    onChanged: (value) {
                      setState(() {
                        selectedAllergies[index] = value!;
                      });
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
