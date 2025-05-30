class Appointment {
  final int id;
  final int userId;
  final int doctorId;
  final DateTime date;
  final String time;
  final String status;

  var reason;

  Appointment({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.date,
    required this.time,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      userId: json['userId'],
      doctorId: json['doctorId'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      status: json['status'],
    );
  }

  get doctorName => null;
}