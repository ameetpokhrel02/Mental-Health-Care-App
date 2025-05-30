const sequelize = require('../config/database');
const User = require('../models/user');
const Doctor = require('../models/doctor');
const Appointment = require('../models/appointment');
const Chat = require('../models/chat');

async function initializeDatabase() {
  try {
    // Create database if it doesn't exist
    await sequelize.query('CREATE DATABASE IF NOT EXISTS mentalcaredb;');
    
    // Sync all models
    await sequelize.sync({ force: true });
    
    console.log('Database initialized successfully');
  } catch (error) {
    console.error('Database initialization failed:', error);
  }
}

initializeDatabase();