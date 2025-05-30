const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const { User, Appointment, Doctor } = require('../models/associations');

router.get('/user-dashboard', auth, async (req, res) => {
  try {
    const user = await User.findByPk(req.user.id);
    const appointments = await Appointment.findAll({
      where: { userId: req.user.id },
      include: [{
        model: Doctor,
        as: 'doctor',
        attributes: ['name', 'email', 'specialization']
      }],
      order: [['appointmentDate', 'ASC']]
    });

    res.json({
      success: true,
      user: {
        id: user.id,
        name: user.name,
        email: user.email
      },
      appointments,
      notifications: appointments.filter(apt => apt.status === 'pending').map(apt => ({
        id: apt.id,
        message: `Upcoming appointment with Dr. ${apt.doctor.name} on ${apt.appointmentDate} at ${apt.appointmentTime}`
      }))
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Failed to fetch dashboard data' });
  }
});

module.exports = router;