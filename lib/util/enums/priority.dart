enum TaskPriority { HIGH, MEDIUM, LOW }

extension PriorityExtension on TaskPriority {
  String getString() {
    if (this == TaskPriority.HIGH)
      return 'High';
    else if (this == TaskPriority.MEDIUM)
      return 'Medium';
    else if (this == TaskPriority.LOW)
      return 'Low';
    else
      throw Exception('Unknown Priority Object');
  }
}
