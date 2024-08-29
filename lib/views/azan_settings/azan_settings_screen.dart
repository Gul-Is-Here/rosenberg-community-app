import 'package:community_islamic_app/constants/color.dart';
import 'package:community_islamic_app/widgets/project_background.dart';
import 'package:flutter/material.dart';

class AzanSettingsScreen extends StatefulWidget {
  const AzanSettingsScreen({super.key});

  @override
  _AzanSettingsScreenState createState() => _AzanSettingsScreenState();
}

class _AzanSettingsScreenState extends State<AzanSettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedAzan = 'Adhan - Makkah';
  final Map<String, bool> _azanTimes = {
    'Fajr': true,
    'Sunrise': false,
    'Dhuhr': true,
    'Asr': true,
    'Maghrib': true,
    'Isha': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildAzanSelection(),
                const SizedBox(height: 20),
                _buildAzanTimeSelection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        const Projectbackground(title: 'PRAYER NOTIFICATION'),
        Padding(
          padding: const EdgeInsets.only(top: 205),
          child: Container(
            height: 45,
            width: double.infinity,
            decoration: BoxDecoration(color: containerConlor),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: Text(
                  'PRAVER NOTIFICATION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAzanSelection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Azan Sound',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              _buildAzanOption('Disable', false),
              _buildAzanOption('Default', false),
              _buildAzanOption('Adhan - Makkah', true),
              _buildAzanOption('Adhan - Madina', false),
              _buildAzanOption('Jamaat Adhan - Oriental style 1', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAzanOption(String title, bool selected) {
    return ListTile(
      leading: Radio<String>(
        activeColor: primaryColor,
        value: title,
        focusColor: primaryColor,
        groupValue: _selectedAzan,
        onChanged: (String? value) {
          setState(() {
            _selectedAzan = value!;
          });
        },
      ),
      title: Text(title),
      trailing: title != 'Disable' && title != 'Default'
          ? IconButton(
              icon: Icon(
                Icons.play_arrow,
                color: primaryColor,
              ),
              onPressed: () {
                // Play the selected Azan sound
              },
            )
          : null,
    );
  }

  Widget _buildAzanTimeSelection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Prayer Time',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                'Time',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  'Alert',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
          Divider(),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: _azanTimes.keys.map((String time) {
              return SwitchListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        time,
                        style: TextStyle(
                          color:
                              time == "Sunrise" ? primaryColor : Colors.black,
                          fontWeight: time == "Sunrise"
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    Text(
                      _getPrayerTime(time),
                      style: TextStyle(
                        color: time == "Sunrise" ? primaryColor : Colors.black,
                        fontWeight: time == "Sunrise"
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                value: _azanTimes[time]!,
                activeColor: primaryColor,
                onChanged: (bool? value) {
                  setState(() {
                    _azanTimes[time] = value!;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _getPrayerTime(String prayer) {
    // Hardcoded prayer times for demonstration
    switch (prayer) {
      case 'Fajr':
        return '04:21 am';
      case 'Sunrise':
        return '05:49 am';
      case 'Dhuhr':
        return '12:38 pm';
      case 'Asr':
        return '04:15 pm';
      case 'Maghrib':
        return '07:12 pm';
      case 'Isha':
        return '08:45 pm';
      default:
        return '';
    }
  }
}
