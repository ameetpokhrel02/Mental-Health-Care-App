import 'package:flutter/material.dart';
import '../../models/appointment.dart';
import '../../services/api_service.dart';
import '../../widgets/appointment_card.dart' show AppointmentCard;
import '../../widgets/calendar_view.dart';

class DoctorDashboard extends StatefulWidget {
  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  List<Appointment> appointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    try {
      final data = await ApiService.getDoctorAppointments();
      setState(() {
        appointments = data.cast<Appointment>();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Doctor Dashboard'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
              Tab(text: 'Schedule'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAppointmentList('pending'),
            _buildAppointmentList('approved'),
            _buildScheduleView(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentList(String status) {
    final filteredAppointments = appointments
        .where((appointment) => appointment.status == status)
        .toList();

    return ListView.builder(
      itemCount: filteredAppointments.length,
      itemBuilder: (context, index) {
        final appointment = filteredAppointments[index];
        return AppointmentCard(
          appointment: appointment,
          onStatusChange: _handleStatusChange,
          onCancel: (id) => _handleStatusChange(id, 'cancelled'),
          onReschedule: (id) => _showRescheduleDialog(id),
        );
      },
    );
  }

  // Add new method for handling reschedule
  Future<void> _showRescheduleDialog(int appointmentId) async {
    DateTime? selectedDate;
    String? selectedTime;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reschedule Appointment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 30)),
                );
                if (date != null) {
                  selectedDate = date;
                }
              },
              child: Text('Select Date'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  selectedTime = '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
                }
              },
              child: Text('Select Time'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (selectedDate != null && selectedTime != null) {
                try {
                  await ApiService.rescheduleAppointment(
                    appointmentId,
                    selectedDate!,
                    selectedTime!,
                  );
                  Navigator.pop(context);
                  _loadAppointments();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              }
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleView() {
    return CalendarView(
      appointments: appointments,
      onDaySelected: (date) {
        // Handle day selection
      },
    );
  }

  Future<void> _handleStatusChange(int appointmentId, String newStatus) async {
    try {
      await ApiService.updateAppointmentStatus(appointmentId, newStatus);
      _loadAppointments();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}