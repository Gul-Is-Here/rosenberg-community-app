import 'package:flutter/material.dart';
import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/controllers/home_events_controller.dart';
import 'package:get/get.dart';

class AnnouncementsDetailsScreen extends StatelessWidget {
  final HomeEventsController controller;
  final String title;
  final String createdDate;
  final String postedDate;
  final String description;
  final String image;

  AnnouncementsDetailsScreen({
    Key? key,
    required this.controller,
    required this.title,
    required this.image,
    required this.createdDate,
    required this.description,
    required this.postedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: primaryColor,
        title: Text(
          "Announcement Details",
          style: TextStyle(fontFamily: popinsSemiBold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Announcement Image with animation
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Hero(
                  tag: title, // for shared element transitions
                  child: Image.network(
                    image,
                    width: double.infinity,
                    height: 250.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 100,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0),

              // Announcement Title with a modern font style
              Text(
                title,
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 10.0),

              // Posted and Created Dates with flexible layout to avoid overflow
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10.0), // Adds a small gap between the rows
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.date_range, color: Colors.grey, size: 18),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'Posted: ${controller.formatDateString(postedDate)}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0), // Additional spacing for better layout

              Divider(height: 30.0, thickness: 1.0),

              // Announcement Description with card layout
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Modern Action Button (Share)
            ],
          ),
        ),
      ),
    );
  }
}
