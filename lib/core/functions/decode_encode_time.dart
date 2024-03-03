import 'package:flutter/material.dart';

encodeTime(TimeOfDay? startTimeP1, TimeOfDay? endTimeP1, TimeOfDay? startTimeP2,
    TimeOfDay? endTimeP2) {
  if (startTimeP1 == null || endTimeP1 == null) {
    return null; // Return null if startTimeP1 or endTimeP1 is null
  }

  String encodedString =
      '${startTimeP1.hour}:${startTimeP1.minute}-${endTimeP1.hour}:${endTimeP1.minute}';

  if (startTimeP2 != null && endTimeP2 != null) {
    encodedString +=
        '|${startTimeP2.hour}:${startTimeP2.minute}-${endTimeP2.hour}:${endTimeP2.minute}';
  }

  return encodedString;
}

Map<String, TimeOfDay?> decodeTimeCustomMoreClean(String encodedString) {
  List<String> periods = encodedString.split('|');
  List<String> period1 = periods[0].split('-');

  TimeOfDay startTimeP1 = parseTimeString(period1[0]);
  TimeOfDay endTimeP1 = parseTimeString(period1[1]);

  if (periods.length == 2) {
    List<String> period2 = periods[1].split('-');
    TimeOfDay startTimeP2 = parseTimeString(period2[0]);
    TimeOfDay endTimeP2 = parseTimeString(period2[1]);

    return {
      'startTimeP1': startTimeP1,
      'endTimeP1': endTimeP1,
      'startTimeP2': startTimeP2,
      'endTimeP2': endTimeP2,
    };
  } else {
    return {
      'startTimeP1': startTimeP1,
      'endTimeP1': endTimeP1,
      'startTimeP2': null,
      'endTimeP2': null,
    };
  }
}

TimeOfDay parseTimeString(String timeString) {
  List<String> timeComponents = timeString.split(':');
  return TimeOfDay(
    hour: int.parse(timeComponents[0]),
    minute: int.parse(timeComponents[1]),
  );
}

// Map<String, TimeOfDay?> decodeTimeCustom(String encodedString) {
//   if (encodedString.contains('|')) {
//     print('it is 2 period');
//     List<String> timePeriods = encodedString.split('|');

//     List<String> period1 = timePeriods[0].split('-');
//     List<String> period2 = timePeriods[1].split('-');

//     TimeOfDay startTimeP1 = TimeOfDay(
//       hour: int.parse(period1[0].split(':')[0]),
//       minute: int.parse(period1[0].split(':')[1]),
//     );
//     TimeOfDay endTimeP1 = TimeOfDay(
//       hour: int.parse(period1[1].split(':')[0]),
//       minute: int.parse(period1[1].split(':')[1]),
//     );

//     TimeOfDay startTimeP2 = TimeOfDay(
//       hour: int.parse(period2[0].split(':')[0]),
//       minute: int.parse(period2[0].split(':')[1]),
//     );
//     TimeOfDay endTimeP2 = TimeOfDay(
//       hour: int.parse(period2[1].split(':')[0]),
//       minute: int.parse(period2[1].split(':')[1]),
//     );

//     return {
//       'startTimeP1': startTimeP1,
//       'endTimeP1': endTimeP1,
//       'startTimeP2': startTimeP2,
//       'endTimeP2': endTimeP2,
//     };
//   } else {
//     print('it is 1 period');
//     List<String> period1 = encodedString.split('-');

//     TimeOfDay startTimeP1 = TimeOfDay(
//       hour: int.parse(period1[0].split(':')[0]),
//       minute: int.parse(period1[0].split(':')[1]),
//     );

//     TimeOfDay endTimeP1 = TimeOfDay(
//       hour: int.parse(period1[1].split(':')[0]),
//       minute: int.parse(period1[1].split(':')[1]),
//     );

//     return {
//       'startTimeP1': startTimeP1,
//       'endTimeP1': endTimeP1,
//       'startTimeP2': null,
//       'endTimeP2': null,
//     };
//   }
// }


