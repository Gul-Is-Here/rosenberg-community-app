import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_events_controller.dart';

class EventsScreen extends StatelessWidget {
  final HomeEventsController eventsController = Get.put(HomeEventsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Events'),
        backgroundColor: Colors.green[800],
      ),
      body: Obx(() {
        if (eventsController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (eventsController.events.value == null ||
            eventsController.events.value!.data.events.isEmpty) {
          return const Center(
            child: Text(
              'No Events Found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: eventsController.events.value!.data.events.length,
            itemBuilder: (context, index) {
              var event = eventsController.events.value!.data.events[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadowColor: Colors.grey.withOpacity(0.4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Image
                        // event.imageUrl != null && event.imageUrl!.isNotEmpty
                        //     ? Image.network(
                        //         event.imageUrl!,
                        //         height: 180,
                        //         width: double.infinity,
                        //         fit: BoxFit.cover,
                        //         errorBuilder: (context, error, stackTrace) {
                        //           // If the image fails to load
                        //           return Image.asset(
                        //             'assets/images/placeholder.png',
                        //             height: 180,
                        //             width: double.infinity,
                        //             fit: BoxFit.cover,
                        //           );
                        //         },
                        //       )
                        //     : Image.asset(
                        //         'assets/images/placeholder.png', // Your local placeholder image
                        //         height: 180,
                        //         width: double.infinity,
                        //         fit: BoxFit.cover,
                        //       ),

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Event Title
                              Text(
                                event.active,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Event Date
                              Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      size: 18, color: Colors.grey[600]),
                                  const SizedBox(width: 5),
                                  Text(
                                    eventsController.formatDateString(
                                        event.eventDate.toString()),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // Event Description
                              Text(
                                event.eventDetail,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
