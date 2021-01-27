mixin DateTimeMixin {
  String getDayOfWeekShort(int dayOfWeek) {
    if (dayOfWeek == 1)
      return 'Mon';
    else if (dayOfWeek == 2)
      return 'Tue';
    else if (dayOfWeek == 3)
      return 'Wed';
    else if (dayOfWeek == 4)
      return 'Thu';
    else if (dayOfWeek == 5)
      return 'Fri';
    else if (dayOfWeek == 6)
      return 'Sat';
    else if (dayOfWeek == 7)
      return 'Sun';
    else
      throw Exception('Unknown Day of Week Parameter.getDayOfWeekShort()');
  }

  String getDayOfWeekLong(int dayOfWeek) {
    if (dayOfWeek == 1)
      return 'Monday';
    else if (dayOfWeek == 2)
      return 'Tuesday';
    else if (dayOfWeek == 3)
      return 'Wednesday';
    else if (dayOfWeek == 4)
      return 'Thursday';
    else if (dayOfWeek == 5)
      return 'Friday';
    else if (dayOfWeek == 6)
      return 'Saturday';
    else if (dayOfWeek == 7)
      return 'Sunday';
    else
      throw Exception('Unknown Day of Week Parameter.getDayOfWeekLong()');
  }

  String mapMonth(int month) {
    if (month == 1)
      return 'January';
    else if (month == 2)
      return 'February';
    else if (month == 3)
      return 'March';
    else if (month == 4)
      return 'April';
    else if (month == 5)
      return 'May';
    else if (month == 6)
      return 'June';
    else if (month == 7)
      return 'July';
    else if (month == 8)
      return 'August';
    else if (month == 9)
      return 'September';
    else if (month == 10)
      return 'October';
    else if (month == 11)
      return 'November';
    else if (month == 12)
      return 'December';
    else
      throw Exception("Couldn't Map month number");
  }

  String getFullDateString(DateTime dateTime) {
    return '${getDayOfWeekLong(dateTime.weekday)}, ${mapMonth(dateTime.month)} ${dateTime.month}, ${dateTime.year}';
  }

  String mapTimeToMeridian(DateTime dateTime){
    String minute = dateTime.minute<10?'0${dateTime.minute}':dateTime.minute.toString();
    if(dateTime.hour==0) return '${12}:$minute AM';
    else if(dateTime.hour==12) return '${12}:$minute PM';
    else if(dateTime.hour<12) return '${dateTime.hour}:$minute AM';
    else return '${dateTime.hour - 12}:$minute PM';
  }
}
