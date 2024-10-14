import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/views/about_us/about_us.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/project_background.dart';

class FamilyMemberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Projectbackground(
              title: 'Family Members',
            ),

            // Family Member section
            Container(
              alignment: Alignment.centerLeft,
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'FAMILY MEMBERS',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: popinsSemiBold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            // Family member card
            FamilyMemberCard(
                heroTag: 'btn22',
                name: 'Mohsin',
                relationship: 'Brother',
                dob: '12-12-2023',
                age: 19),
            FamilyMemberCard(
              heroTag: 'btn33',
              name: 'MOEED',
              relationship: 'BROTHER',
              dob: '09/03/2005',
              age: 19,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        // Wrap the FAB in a Container
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradianColor2,
              gradianColor1,
            ], // Define your gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle, // Ensures the container is circular
        ),
        child: FloatingActionButton(
          heroTag: 'btn1',
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(width: 2, color: whiteColor)),
          backgroundColor:
              Colors.transparent, // Set backgroundColor to transparent
          child: Icon(
            Icons.add,
            color: Colors.white,
          ), // FAB icon
          onPressed: () {
            // Action when the FAB is pressed
            print('FAB Pressed');
          },
        ),
      ),
      // floatingActionButtonLocation:
      // FloatingActionButtonLocation., // Center the FAB
    );
  }
}

class FamilyMemberCard extends StatefulWidget {
  final String name;
  final String relationship;
  final String dob;
  final int age;
  final String heroTag;

  FamilyMemberCard({
    required this.heroTag,
    required this.name,
    required this.relationship,
    required this.dob,
    required this.age,
  });

  @override
  _FamilyMemberCardState createState() => _FamilyMemberCardState();
}

class _FamilyMemberCardState extends State<FamilyMemberCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        AssetImage('assets/images/boy.png'), // Profile picture
                  ),
                  title: Text(
                    widget.name,
                    style: TextStyle(fontFamily: popinsBold, fontSize: 13),
                  ),
                  subtitle: Text(
                    '${widget.relationship} - ${widget.dob} - ${widget.age} Years',
                    style:
                        const TextStyle(fontFamily: popinsBold, fontSize: 10),
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: whiteColor,
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: whiteColor,
                        size: 35,
                      ),
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                    ),
                  ),
                ),
                if (isExpanded)
                  Column(
                    children: [
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 28,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: primaryColor,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'GENERAL INFORMATION',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: popinsSemiBold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Name ',
                                    style: TextStyle(
                                        fontFamily: popinsRegulr, fontSize: 10),
                                  ),
                                  Text(
                                    widget.name,
                                    style: TextStyle(
                                        fontFamily: popinsRegulr, fontSize: 10),
                                  ),
                                  Text(
                                    'Relation',
                                    style: TextStyle(
                                        fontFamily: popinsRegulr, fontSize: 10),
                                  ),
                                  Text(
                                    widget.relationship,
                                    style: TextStyle(
                                        fontFamily: popinsRegulr, fontSize: 10),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'DOB',
                                    style: TextStyle(
                                        fontFamily: popinsRegulr, fontSize: 10),
                                  ),
                                  Text(
                                    widget.dob,
                                    style: TextStyle(
                                        fontFamily: popinsRegulr, fontSize: 10),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      'Age',
                                      style: TextStyle(
                                          fontFamily: popinsRegulr,
                                          fontSize: 10),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 35),
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      widget.age.toString(),
                                      style: TextStyle(
                                          fontFamily: popinsRegulr,
                                          fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 28,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: primaryColor,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'AVAILABLE CLASSES',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: popinsSemiBold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: Card(
                                    margin: EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                      child: DropdownButton<String>(
                                        // elevation: 5,
                                        // borderRadius: BorderRadius.circular(40),
                                        dropdownColor: Colors.white,
                                        underline:
                                            Container(), // Remove default underline
                                        items: <String>[
                                          'View Details',
                                          'Enrole in Class',
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  fontFamily: popinsRegulr,
                                                  fontSize: 13),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (_) {},
                                        hint: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            'Class A',
                                            style: TextStyle(
                                                fontFamily: popinsBold,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 28,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: primaryColor,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'CLASSES ENROLLED',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: popinsSemiBold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
                            child: Stack(
                              children: [
                                // 40.heightBox,
                                Positioned(
                                    left: 20,
                                    bottom: 45,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: const BoxDecoration(
                                          color: Color(0xFFFED36A),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              topRight: Radius.circular(5))),
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 3),
                                        child: Text(
                                          'waiting for Approval',
                                          style: TextStyle(
                                              fontFamily: popinsSemiBold,
                                              fontSize: 8),
                                        ),
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        child: Card(
                                          color: const Color(0xFF1EC7CD),
                                          margin: EdgeInsets.all(0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                            child: DropdownButton<String>(
                                              // elevation: 5,
                                              // borderRadius: BorderRadius.circular(40),
                                              dropdownColor: Colors.white,
                                              underline:
                                                  Container(), // Remove default underline
                                              items: <String>[
                                                'View Details',
                                                'Enrole in Class',
                                              ].map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            popinsRegulr,
                                                        fontSize: 13),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (_) {},
                                              hint: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Text(
                                                  'Class A',
                                                  style: TextStyle(
                                                      fontFamily: popinsBold,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      // EnrolledClassBadge(
                                      //     'Class B', Colors.green, 'Approved'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
          // Positioned Edit Button, half on and half off the card
          Positioned(
            bottom: -20,
            right: 120,
            child: FloatingActionButton(
              heroTag: widget.heroTag,
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: whiteColor),
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                // Edit action
              },
              mini: true,
              backgroundColor: Colors.red,
              child: Icon(
                Icons.close,
                color: whiteColor,
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            right: 165,
            child: FloatingActionButton(
              heroTag: widget.heroTag,
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: whiteColor),
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                // Edit action
              },
              mini: true,
              backgroundColor: primaryColor,
              child: Icon(
                Icons.edit,
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
