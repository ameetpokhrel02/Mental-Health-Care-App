const User = require('./user');
const Doctor = require('./doctor');
const Appointment = require('./appointment');

// Define associations
User.hasMany(Appointment, {
  foreignKey: 'userId',
  as: 'appointments'
});

Appointment.belongsTo(User, {
  foreignKey: 'userId',
  as: 'patient'
});

Doctor.hasMany(Appointment, {
  foreignKey: 'doctorId',
  as: 'doctorAppointments'
});

Appointment.belongsTo(Doctor, {
  foreignKey: 'doctorId',
  as: 'doctor'
});

module.exports = {
  User,
  Doctor,
  Appointment
};