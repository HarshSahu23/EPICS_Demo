import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
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
                      Row(
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
          )
        ],
      ),
    );
  }
}
