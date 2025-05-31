require('dotenv').config();
const express = require('express');
const cors = require('cors');
const db = require('./config/database');
const app = express();

app.use(cors());
app.use(express.json());

// Import models directly
const User = require('./models/user');
const Doctor = require('./models/doctor');
const Appointment = require('./models/appointment'); // Fix capitalization to match file name

// Import associations after models
require('./models/associations');

// Import routes
const authRoutes = require('./routes/auth');
const doctorRoutes = require('./routes/doctors');
const appointmentRoutes = require('./routes/appointments');
const userRoutes = require('./routes/users');
const reviewRoutes = require('./routes/reviews');
const chatRoutes = require('./routes/chats');
const dashboardRoutes = require('./routes/dashboard');

// Verify routes before using them
if (authRoutes.stack) app.use('/api/auth', authRoutes);
if (doctorRoutes.stack) app.use('/api/doctors', doctorRoutes);
if (appointmentRoutes.stack) app.use('/api/appointments', appointmentRoutes);
if (userRoutes.stack) app.use('/api/users', userRoutes);
if (reviewRoutes.stack) app.use('/api/reviews', reviewRoutes);
if (chatRoutes.stack) app.use('/api/chats', chatRoutes);
app.use('/api/dashboard', dashboardRoutes);

const PORT = process.env.PORT || 5000;

// Test DB Connection and sync models
db.authenticate()
  .then(() => {
    console.log('Database connected...');
    return db.sync({ alter: true });
  })
  .then(() => console.log('Models synchronized with database'))
  .catch(err => console.log('Error: ' + err));

app.listen(PORT, () => console.log(`Server is running on port ${PORT}`));
