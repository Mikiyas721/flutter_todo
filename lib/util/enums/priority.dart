enum TaskPriority { HIGH, MEDIUM, LOW }

extension TaskPriorityExtension on TaskPriority {
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
  static TaskPriority fromString(String priority) {
    if (priority=='High') return TaskPriority.HIGH;
    else if (priority=='Medium') return TaskPriority.MEDIUM;
    else if (priority=='Low') return TaskPriority.LOW;
    else
      throw Exception('Unknown Priority Object');
  }
}
