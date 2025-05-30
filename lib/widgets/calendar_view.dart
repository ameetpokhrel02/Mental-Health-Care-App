import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/appointment.dart';

class CalendarView extends StatefulWidget {
  final List<Appointment> appointments;
  final Function(DateTime) onDaySelected;

  const CalendarView({
    Key? key,
    required this.appointments,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(Duration(days: 365)),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            widget.onDaySelected(selectedDay);
          },
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          eventLoader: (day) {
            return widget.appointments
                .where((appointment) => 
                    isSameDay(appointment.date, day))
                .toList();
          },
        ),
        Expanded(
          child: _buildEventList(),
        ),
      ],
    );
  }

  Widget _buildEventList() {
    if (_selectedDay == null) return Container();

    final dayAppointments = widget.appointments
        .where((appointment) => 
            isSameDay(appointment.date, _selectedDay!))
        .toList();

    return ListView.builder(
      itemCount: dayAppointments.length,
      itemBuilder: (context, index) {
        final appointment = dayAppointments[index];
        return ListTile(
          title: Text('Appointment at ${appointment.time}'),
          subtitle: Text('Patient ID: ${appointment.userId}'),
        );
      },
    );
  }
}