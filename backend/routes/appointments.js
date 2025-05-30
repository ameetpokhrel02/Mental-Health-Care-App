const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const { Appointment, Doctor, User } = require('../models/associations');
const { Op } = require('sequelize');

// Book appointment
router.post('/book', auth, async (req, res) => {
  try {
    const { doctorId, appointmentDate, appointmentTime, reason } = req.body;

    // Check for existing appointment
    const existingAppointment = await Appointment.findOne({
      where: {
        doctorId,
        appointmentDate,
        appointmentTime,
        status: {
          [Op.ne]: 'cancelled'
        }
      }
    });

    if (existingAppointment) {
      return res.status(400).json({
        success: false,
        message: 'This time slot is already booked'
      });
    }

    const appointment = await Appointment.create({
      userId: req.user.id,
      doctorId,
      appointmentDate,
      appointmentTime,
      reason,
      status: 'pending'
    });

    // Get doctor details for notification
    const doctor = await Doctor.findByPk(doctorId);

    // Add notification
    await Notification.create({
      userId: req.user.id,
      doctorId,
      message: `Appointment booked with Dr. ${doctor.name} for ${appointmentDate} at ${appointmentTime}`,
      type: 'appointment_booked'
    });

    res.status(201).json({
      success: true,
      message: `Appointment booked successfully with Dr. ${doctor.name}`,
      appointment,
      notification: {
        message: `Appointment booked for ${appointmentDate} at ${appointmentTime}`
      }
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Failed to book appointment' });
  }
});

// Get user's appointments
router.get('/user-appointments', auth, async (req, res) => {
  try {
    const appointments = await Appointment.findAll({
      where: { userId: req.user.id },
      include: [{
        model: Doctor,
        as: 'doctor',
        attributes: ['name', 'email', 'specialization']
      }],
      order: [
        ['appointmentDate', 'ASC'],
        ['appointmentTime', 'ASC']
      ]
    });

    res.json({
      success: true,
      appointments
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Failed to fetch appointments' });
  }
});

// Delete appointment
router.delete('/:id', auth, async (req, res) => {
  try {
    const appointment = await Appointment.findOne({
      where: {
        id: req.params.id,
        userId: req.user.id
      }
    });

    if (!appointment) {
      return res.status(404).json({
        success: false,
        message: 'Appointment not found'
      });
    }

    await appointment.destroy();
    res.json({
      success: true,
      message: 'Appointment cancelled successfully'
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Failed to cancel appointment' });
  }
});

// Update appointment
router.put('/:id', auth, async (req, res) => {
  try {
    const { appointmentDate, appointmentTime, reason } = req.body;
    const appointment = await Appointment.findOne({
      where: {
        id: req.params.id,
        userId: req.user.id
      }
    });

    if (!appointment) {
      return res.status(404).json({
        success: false,
        message: 'Appointment not found'
      });
    }

    await appointment.update({
      appointmentDate,
      appointmentTime,
      reason
    });

    res.json({
      success: true,
      message: 'Appointment updated successfully',
      appointment
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Failed to update appointment' });
  }
});

// Add this to your existing appointments.js file

// Search doctors
router.get('/search-doctors', auth, async (req, res) => {
  try {
    const { query, specialization } = req.query;
    const whereClause = {};
    
    if (query) {
      whereClause.name = { [Op.like]: `%${query}%` };
    }
    if (specialization) {
      whereClause.specialization = specialization;
    }

    const doctors = await Doctor.findAll({
      where: whereClause,
      attributes: ['id', 'name', 'email', 'specialization']
    });

    res.json({
      success: true,
      doctors
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Failed to search doctors' });
  }
});

// Get available time slots
router.get('/available-slots/:doctorId', auth, async (req, res) => {
  try {
    const { date } = req.query;
    const bookedSlots = await Appointment.findAll({
      where: {
        doctorId: req.params.doctorId,
        appointmentDate: date,
        status: {
          [Op.ne]: 'cancelled'
        }
      },
      attributes: ['appointmentTime']
    });

    const allSlots = generateTimeSlots(); // Implement this helper function
    const availableSlots = allSlots.filter(slot => 
      !bookedSlots.find(booked => booked.appointmentTime === slot)
    );

    res.json({
      success: true,
      availableSlots
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Failed to fetch available slots' });
  }
});

// Helper function to generate time slots
function generateTimeSlots() {
  const slots = [];
  const start = 9; // 9 AM
  const end = 17; // 5 PM
  
  for (let hour = start; hour < end; hour++) {
    slots.push(`${hour}:00`);
    slots.push(`${hour}:30`);
  }
  
  return slots;
}

// Update existing book appointment route to include notifications
router.post('/book', auth, async (req, res) => {
  try {
    const { doctorId, appointmentDate, appointmentTime, reason } = req.body;

    // Check for existing appointment
    const existingAppointment = await Appointment.findOne({
      where: {
        doctorId,
        appointmentDate,
        appointmentTime,
        status: {
          [Op.ne]: 'cancelled'
        }
      }
    });

    if (existingAppointment) {
      return res.status(400).json({
        success: false,
        message: 'This time slot is already booked'
      });
    }

    const appointment = await Appointment.create({
      userId: req.user.id,
      doctorId,
      appointmentDate,
      appointmentTime,
      reason,
      status: 'pending'
    });

    // Get doctor details for notification
    const doctor = await Doctor.findByPk(doctorId);

    // Add notification
    await Notification.create({
      userId: req.user.id,
      doctorId,
      message: `Appointment booked with Dr. ${doctor.name} for ${appointmentDate} at ${appointmentTime}`,
      type: 'appointment_booked'
    });

    res.status(201).json({
      success: true,
      message: `Appointment booked successfully with Dr. ${doctor.name}`,
      appointment,
      notification: {
        message: `Appointment booked for ${appointmentDate} at ${appointmentTime}`
      }
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Failed to book appointment' });
  }
});

module.exports = router;