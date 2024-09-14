import 'dart:async';

// import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AzanNotificationScreen extends StatefulWidget {
  const AzanNotificationScreen({super.key});

  @override
  State<AzanNotificationScreen> createState() => _AzanNotificationScreenState();
}

class _AzanNotificationScreenState extends State<AzanNotificationScreen> {
  // late List<AlarmSettings> alarms;
  // static StreamSubscription<AlarmSettings>? subscription;

  @override
  void initState() {
    super.initState();
    // if (Alarm.android) {
    // checkAndroidNotificationPermission();
    // checkAndroidScheduleExactAlarmPermission();
    // }
    // scheduleAzanNotification();
    // subscription ??= Alarm.ringStream.stream.listen(onAlarmRing);
  }

  // Future<void> scheduleAzanNotification() async {
  //   // Cancel all existing alarms to avoid duplication
  //   await Alarm.stopAll();

  //   final now = DateTime.now();
  //   final alarmSettings = AlarmSettings(
  //     id: 1,
  //     dateTime: now.add(const Duration(seconds: 10)), // Schedules the first alarm 10 seconds from now
  //     loopAudio: true,
  //     vibrate: true,
  //     notificationTitle: 'Azan Time!',
  //     notificationBody: 'It\'s time for Azan!',
  //     assetAudioPath: 'assets/audio/azan1.mp3', // Path to your Azan audio file
  //   );

  //   await Alarm.set(alarmSettings: alarmSettings);

  //   // Schedule the next alarm to repeat every 10 seconds
  //   Timer.periodic(const Duration(seconds: 10), (timer) async {
  //     final nextAlarm = AlarmSettings(
  //       id: timer.tick + 1, // Unique ID for each alarm
  //       dateTime: DateTime.now().add(const Duration(seconds: 10)),
  //       loopAudio: true,
  //       vibrate: true,
  //       notificationTitle: 'Azan Time!',
  //       notificationBody: 'It\'s time for Azan!',
  //       assetAudioPath: 'assets/audio/azan1.mp3',
  //     );

  //     await Alarm.set(alarmSettings: nextAlarm);
  //   });
  // }

  // Future<void> onAlarmRing(AlarmSettings alarmSettings) async {
  //   // This method is triggered when the alarm rings
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute<void>(
  //       builder: (context) => AzanRingScreen(alarmSettings: alarmSettings),
  //     ),
  //   );
  //   scheduleAzanNotification(); // Reschedule after alarm is dismissed
  // }

  // Future<void> checkAndroidNotificationPermission() async {
  //   final status = await Permission.notification.status;
  //   if (status.isDenied) {
  //     final res = await Permission.notification.request();
  //     if (res.isDenied) {
  //       print('Notification permission denied');
  //     }
  //   }
  // }

  Future<void> checkAndroidScheduleExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.status;
    if (status.isDenied) {
      final res = await Permission.scheduleExactAlarm.request();
      if (res.isDenied) {
        print('Schedule exact alarm permission denied');
      }
    }
  }

  @override
  void dispose() {
    // subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Azan Notifications')),
      body: Center(
        child: Text(
          'Azan notifications will be scheduled every 10 seconds.',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class AzanRingScreen extends StatelessWidget {

  // final AlarmSettings alarmSettings;

  const AzanRingScreen({
    // required this.alarmSettings,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Azan Ringing')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Azan Time!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Alarm.stop(alarmSettings.id); // Stops the current alarm
                Navigator.pop(context);
              },
              child: const Text('Stop Azan'),
            ),
          ],
        ),
      ),
    );
  }
}
