import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/appointment.dart';

// CalendarView widget displays a calendar with appointments and allows day selection
class CalendarView extends StatefulWidget {
  // List of appointments to display on the calendar
  final List<Appointment> appointments;
  // Callback function triggered when a day is selected
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
  // Current calendar view format (month, week, etc.)
  CalendarFormat _calendarFormat = CalendarFormat.month;
  // Currently focused day in the calendar
  DateTime _focusedDay = DateTime.now();
  // Currently selected day by the user
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TableCalendar widget for displaying the calendar
        TableCalendar(
          // Calendar range configuration
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(Duration(days: 365)),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          
          // Determines which day is currently selected
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          
          // Handles day selection events
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            widget.onDaySelected(selectedDay);
          },
          
          // Handles calendar format changes (month/week view)
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          
          // Loads appointments for each day to show indicators
          eventLoader: (day) {
            return widget.appointments
                .where((appointment) =>
                    isSameDay(appointment.date, day))
                .toList();
          },
        ),
        // List of appointments for the selected day
        Expanded(
          child: _buildEventList(),
        ),
      ],
    );
  }

  // Builds a list of appointments for the selected day
  Widget _buildEventList() {
    // Return empty container if no day is selected
    if (_selectedDay == null) return Container();

    // Filter appointments for the selected day
    final dayAppointments = widget.appointments
        .where((appointment) =>
            isSameDay(appointment.date, _selectedDay!))
        .toList();

    // Display appointments in a scrollable list
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