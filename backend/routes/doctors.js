const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const { Doctor, Appointment, User } = require('../models/associations');

// Get doctor's dashboard data
router.get('/dashboard', auth, async (req, res) => {
  try {
    const doctor = await Doctor.findByPk(req.user.id);
    const appointments = await Appointment.findAll({
      where: { doctorId: req.user.id },
      include: [{
        model: User,
        as: 'patient',
        attributes: ['name', 'email']
      }],
      order: [['appointmentDate', 'ASC'], ['appointmentTime', 'ASC']]
    });

    res.json({
      success: true,
      doctor: {
        id: doctor.id,
        name: doctor.name,
        email: doctor.email,
        specialization: doctor.specialization
      },
      appointments
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Failed to fetch dashboard data' });
  }
});

// Update appointment time by doctor
router.put('/reschedule-appointment/:id', auth, async (req, res) => {
  try {
    const { appointmentDate, appointmentTime } = req.body;
    const appointment = await Appointment.findOne({
      where: {
        id: req.params.id,
        doctorId: req.user.id
      },
      include: [{
        model: User,
        as: 'patient',
        attributes: ['name', 'email']
      }]
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
      status: 'rescheduled'
    });

    res.json({
      success: true,
      message: `Appointment rescheduled successfully with ${appointment.patient.name}`,
      appointment
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Failed to reschedule appointment' });
  }
});

module.exports = router;