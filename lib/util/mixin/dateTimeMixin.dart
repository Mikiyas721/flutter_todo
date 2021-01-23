mixin DateTimeMixin {
  String getDayOfWeek(int dayOfWeek) {
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
      throw Exception('Unknown Day of Week Parameter');
  }

  String mapMonth(int month) {
    if (month == 1)
      return 'January';
    else if (month == 1)
      return 'February';
    else if (month == 1)
      return 'March';
    else if (month == 1)
      return 'April';
    else if (month == 1)
      return 'May';
    else if (month == 1)
      return 'June';
    else if (month == 1)
      return 'July';
    else if (month == 1)
      return 'August';
    else if (month == 1)
      return 'September';
    else if (month == 1)
      return 'October';
    else if (month == 1)
      return 'November';
    else if (month == 1)
      return 'December';
    else
      throw Exception("Couldn't Map month number");
  }
}
