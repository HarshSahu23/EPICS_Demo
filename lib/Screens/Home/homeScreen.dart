import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import '../theme.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();

  headerCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 15, 5, 5),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/weather.png"),
                      height: 38,
                      width: 38,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Good Morning, User ",
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: 260,
                  height: 38,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.mic),
                        onPressed: () {
                          // Handle microphone button press
                          print('Microphone button pressed');
                        },
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade400,
            radius: 44,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/man.png"),
              backgroundColor: Colors.black.withOpacity(0.0),
              radius: 42,
            ),
          )
        ],
      ),
    );
  }

  addDateBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 75,
        initialSelectedDate: DateTime.now(),
        selectionColor: Themes.primaryClr,
        selectedTextColor: Colors.white,
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  horizontalDivider() {
    return Container(
      height: 20, // Set the desired height
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 16.0), // Adjust spacing as needed
              height: 2, // Divider thickness
              color: Colors.grey, // Divider color
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          headerCard(),
          addDateBar(),
          horizontalDivider(),
          TabbedDropDowns()
        ],
      ),
    );
  }
}

class TabbedDropDowns extends StatefulWidget {
  @override
  _TabbedDropDownsState createState() => _TabbedDropDownsState();
}

class _TabbedDropDownsState extends State<TabbedDropDowns> {
  int selectedIndex = 0;

  List<String> tabTitles = ['Medicine', 'Doctor', 'Checkup'];

  List<Widget> cardContents = [
    CustomCard(
      Item1Name: "Lorem ipsum dolor",
      Item2Name: "consectetur adipiscing",
      Item3Name: "sed do eiusmod",
      isItem1Checked: true,
      isItem2Checked: true,
      isItem3Checked: false,
      imagePath: "assets/drugs.png",
    ),
    CustomCard(
      Item1Name: "quis nostrud exercitation",
      Item2Name: "cillum dolore eu",
      Item3Name: "minim veniam",
      isItem1Checked: false,
      isItem2Checked: false,
      isItem3Checked: true,
      imagePath: "assets/doctor.png",
    ),
    CustomCard(
      Item1Name: "Excepteur sint occaecat",
      Item2Name: "beatae vitae dicta",
      Item3Name: "Ut enim ad minima",
      isItem1Checked: false,
      isItem2Checked: true,
      isItem3Checked: true,
      imagePath: "assets/appt.png",
    )
  ];

  List<bool> isCardVisible = [true, false, false];

  void toggleCardVisibility(int index) {
    setState(() {
      for (int i = 0; i < isCardVisible.length; i++) {
        isCardVisible[i] = i == index;
      }
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(15, 5, 5, 0),
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                tabTitles.length,
                (index) => GestureDetector(
                  onTap: () => toggleCardVisibility(index),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    color:
                        index == selectedIndex ? Themes.bluishClr : Colors.grey,
                    child: Text(
                      tabTitles[index],
                      style: GoogleFonts.nunito(
                          color: index == selectedIndex
                              ? Themes.yellowClr
                              : Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 24),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Visibility(visible: isCardVisible[0], child: cardContents[0]),
          Visibility(visible: isCardVisible[1], child: cardContents[1]),
          Visibility(visible: isCardVisible[2], child: cardContents[2]),
        ],
      ),
    );
  }
}

// class DropDownCard extends StatefulWidget {
//   final VoidCallback onToggle;
//   final bool isExpanded;

//   DropDownCard({
//     Key? key,
//     required this.onToggle,
//     required this.isExpanded,
//   }) : super(key: key);

//   @override
//   State<DropDownCard> createState() => _DropDownCardState();
// }

// class _DropDownCardState extends State<DropDownCard> {
//   // bool _isVisible = true;
//   // String hintText = "Collapse";
//   // IconData hintIcon = Icons.keyboard_arrow_up;
//   // void hideCard() {
//   //   setState() {
//   //     print("tried to collapse");
//   //     _isVisible = !_isVisible;
//   //     hintText = hintText == "Collapse" ? "Expand" : "Collapse";
//   //     hintIcon = hintIcon == Icons.keyboard_arrow_up
//   //         ? Icons.keyboard_arrow_down
//   //         : Icons.keyboard_arrow_up;
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // GestureDetector(
//         //   onTap: hideCard,
//         //   child: Row(
//         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //     children: [
//         //       Text(
//         //         'Tap to $hintText',
//         //         style: const TextStyle(fontSize: 20),
//         //       ),
//         //       Icon(hintIcon),
//         //     ],
//         //   ),
//         // ),
//         Visibility(visible: true, child: CustomCard())
//       ],
//     );
//   }
// }

class CustomCard extends StatefulWidget {
  final String Item1Name;
  final String Item2Name;
  final String Item3Name;
  bool isItem1Checked; // Initial state of checkbox for Item 1
  bool isItem2Checked; // Initial state of checkbox for Item 2
  bool isItem3Checked; // Initial state of checkbox for Item 2
  final String imagePath;

  CustomCard(
      {Key? key,
      required this.Item1Name,
      required this.Item2Name,
      required this.Item3Name,
      required this.isItem1Checked,
      required this.isItem2Checked,
      required this.isItem3Checked,
      required this.imagePath})
      : super(key: key);
  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Scrollbar(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(widget.Item1Name),
                      trailing: Checkbox(
                        autofocus: true,
                        checkColor: Themes.pinkClr,
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        value: widget.isItem1Checked,
                        onChanged: (newValue) {
                          setState(() {
                            widget.isItem1Checked = newValue ?? false;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(widget.Item2Name),
                      trailing: Checkbox(
                        autofocus: true,
                        checkColor: Themes.pinkClr,
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        value: widget.isItem2Checked,
                        onChanged: (newValue) {
                          setState(() {
                            widget.isItem2Checked = newValue ?? false;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(widget.Item3Name),
                      trailing: Checkbox(
                        autofocus: true,
                        checkColor: Themes.pinkClr,
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        value: widget.isItem3Checked,
                        onChanged: (newValue) {
                          setState(() {
                            widget.isItem3Checked = newValue ?? false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15),
              height: 100,
              child: Expanded(
                flex: 1,
                child: Image.asset(
                  widget.imagePath, // Replace with your image asset path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
