import 'package:flutter/material.dart';
import '../models/appointment.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final Function(int) onCancel;
  final Function(int) onReschedule;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    required this.onCancel,
    required this.onReschedule, required Future<void> Function(int appointmentId, String newStatus) onStatusChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _getStatusColor(appointment.status),
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dr. ${appointment.doctorName}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildStatusChip(appointment.status),
                ],
              ),
              SizedBox(height: 12),
              _buildInfoRow(Icons.calendar_today, 
                DateFormat('MMM dd, yyyy').format(appointment.date)),
              SizedBox(height: 8),
              _buildInfoRow(Icons.access_time, appointment.time),
              if (appointment.reason != null)
                _buildInfoRow(Icons.note, appointment.reason!),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (appointment.status == 'pending' || 
                      appointment.status == 'confirmed')
                    TextButton.icon(
                      onPressed: () => onReschedule(appointment.id),
                      icon: Icon(Icons.schedule),
                      label: Text('Reschedule'),
                    ),
                  SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () => onCancel(appointment.id),
                    icon: Icon(Icons.cancel, color: Colors.red),
                    label: Text('Cancel', 
                      style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: _getStatusColor(status),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}