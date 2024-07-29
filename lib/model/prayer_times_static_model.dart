class StaticPrayarTimes {
  final String startDate;
  final String endDate;
  final String fjar;
  final String zuhr;
  final String asr;
  final String magrib;
  final String isha;
  StaticPrayarTimes(
      {required this.startDate,
      required this.endDate,
      required this.fjar,
      required this.zuhr,
      required this.asr,
      required this.magrib,
      required this.isha});
}

//Prayar Static Times
List<StaticPrayarTimes> iqamahTiming = [
  StaticPrayarTimes(
      startDate: "1/1",
      endDate: "14/1",
      fjar: "6:25 AM",
      zuhr: "2:00 PM",
      asr: "4:15 PM",
      magrib: "Sunset + 5 min",
      isha: "7:30 PM"),
  StaticPrayarTimes(
      startDate: "15/1",
      endDate: "31/1",
      fjar: "6:25 AM",
      zuhr: "2:00 PM",
      asr: "4:30 PM",
      magrib: "Sunset + 5 min",
      isha: "7:30 PM"),
  StaticPrayarTimes(
      startDate: "1/2",
      endDate: "14/2",
      fjar: "6:20 AM",
      zuhr: "2:00 PM",
      asr: "4:45 PM",
      magrib: "Sunset + 5 min",
      isha: "7:45 PM"),
  StaticPrayarTimes(
      startDate: "15/2",
      endDate: "28/2",
      fjar: "6:10 AM",
      zuhr: "2:00 PM",
      asr: "4:45 PM",
      magrib: "Sunset + 5 min",
      isha: "8:00 PM"),
  StaticPrayarTimes(
      startDate: "1/3",
      endDate: "9/3",
      fjar: "5:55 AM",
      zuhr: "2:00 PM",
      asr: "5:00 PM",
      magrib: "Sunset + 5 min",
      isha: "8:00 PM"),
  StaticPrayarTimes(
      startDate: "10/3",
      endDate: "19/3",
      fjar: "6:45 AM",
      zuhr: "2:00 PM",
      asr: "6:15 PM",
      magrib: "Sunset + 5 min",
      isha: "9:00 PM"),
  StaticPrayarTimes(
      startDate: "20/3",
      endDate: "31/3",
      fjar: "6:35 AM",
      zuhr: "2:00 PM",
      asr: "6:15 PM",
      magrib: "Sunset + 5 min",
      isha: "9:15 PM"),
  StaticPrayarTimes(
      startDate: "1/4",
      endDate: "14/4",
      fjar: "6:20 AM",
      zuhr: "2:00 PM",
      asr: "6:15 PM",
      magrib: "Sunset + 5 min",
      isha: "9:15 PM"),
  StaticPrayarTimes(
      startDate: "15/4",
      endDate: "30/4",
      fjar: "6:00 AM",
      zuhr: "2:00 PM",
      asr: "6:15 PM",
      magrib: "Sunset + 5 min",
      isha: "9:20 PM"),
  StaticPrayarTimes(
      startDate: "1/5",
      endDate: "14/5",
      fjar: "5:45 AM",
      zuhr: "2:00 PM",
      asr: "6:15 PM",
      magrib: "Sunset + 5 min",
      isha: "9:30 PM"),
  StaticPrayarTimes(
      startDate: "15/5",
      endDate: "31/5",
      fjar: "5:30 AM",
      zuhr: "2:00 PM",
      asr: "6:30 PM",
      magrib: "Sunset + 5 min",
      isha: "9:45 PM"),
  StaticPrayarTimes(
      startDate: "1/6",
      endDate: "14/7",
      fjar: "5:30 AM",
      zuhr: "2:00 PM",
      asr: "6:30 PM",
      magrib: "Sunset + 5 min",
      isha: "9:50 PM"),
  StaticPrayarTimes(
      startDate: "15/7",
      endDate: "31/7",
      fjar: "5:45 AM",
      zuhr: "2:00 PM",
      asr: "6:30 PM",
      magrib: "Sunset + 5 min",
      isha: "9:45 PM"),
  StaticPrayarTimes(
      startDate: "1/8",
      endDate: "14/8",
      fjar: "5:55 AM",
      zuhr: "2:00 PM",
      asr: "6:30 PM",
      magrib: "Sunset + 5 min",
      isha: "9:35 PM"),
  StaticPrayarTimes(
      startDate: "15/8",
      endDate: "31/8",
      fjar: "6:10 AM",
      zuhr: "2:00 PM",
      asr: "6:15 PM",
      magrib: "Sunset + 5 min",
      isha: "9:20 PM"),
  StaticPrayarTimes(
      startDate: "1/9",
      endDate: "14/9",
      fjar: "6:15 AM",
      zuhr: "2:00 PM",
      asr: "6:05 PM",
      magrib: "Sunset + 5 min",
      isha: "9:00 PM"),
  StaticPrayarTimes(
      startDate: "15/9",
      endDate: "30/9",
      fjar: "6:25 AM",
      zuhr: "2:00 PM",
      asr: "6:00 PM",
      magrib: "Sunset + 5 min",
      isha: "8:45 PM"),
  StaticPrayarTimes(
      startDate: "1/10",
      endDate: "14/10",
      fjar: "6:35 AM",
      zuhr: "2:00 PM",
      asr: "5:40 PM",
      magrib: "Sunset + 5 min",
      isha: "8:30 PM"),
  StaticPrayarTimes(
      startDate: "15/10",
      endDate: "31/10",
      fjar: "6:45 AM",
      zuhr: "2:00 PM",
      asr: "5:25 PM",
      magrib: "Sunset + 5 min",
      isha: "8:15 PM"),
  StaticPrayarTimes(
      startDate: "1/11",
      endDate: "2/11",
      fjar: "6:45 AM",
      zuhr: "2:00 PM",
      asr: "5:25 PM",
      magrib: "Sunset + 5 min",
      isha: "8:15 PM"),
  StaticPrayarTimes(
      startDate: "3/11",
      endDate: "14/11",
      fjar: "5:55 AM",
      zuhr: "2:00 PM",
      asr: "4:10 PM",
      magrib: "Sunset + 5 min",
      isha: "9:30 PM"),
  StaticPrayarTimes(
      startDate: "15/11",
      endDate: "31/11",
      fjar: "6:05 AM",
      zuhr: "2:00 PM",
      asr: "4:00 PM",
      magrib: "Sunset + 5 min",
      isha: "9:30 PM"),
  StaticPrayarTimes(
      startDate: "1/12",
      endDate: "30/12",
      fjar: "6:20 AM",
      zuhr: "2:00 PM",
      asr: "4:00 PM",
      magrib: "Sunset + 5 min",
      isha: "9:30 PM"),
];
