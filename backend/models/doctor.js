const Sequelize = require('sequelize');
const db = require('../config/database');
const bcrypt = require('bcryptjs');  // For password encryption

const Doctor = db.define('doctors', {
  id: {
    type: Sequelize.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  name: {
    type: Sequelize.STRING
  },
  specialization: {
    type: Sequelize.STRING
  },
  experience: {
    type: Sequelize.INTEGER
  },
  imageUrl: {
    type: Sequelize.STRING
  },
  email: {
    type: Sequelize.STRING,
    allowNull: false,  // email cannot be null
    unique: true,      // ensure that each email is unique
    validate: {
      isEmail: true     // validate that the email is in the correct format
    }
  },
  password: {
    type: Sequelize.STRING,
    allowNull: false,  // password cannot be null
    validate: {
      len: [8, 100]  // password should be between 8 and 100 characters
    }
  }
}, {
  timestamps: true,
  hooks: {
    // Before saving, encrypt the password
    beforeCreate: async (doctor) => {
      if (doctor.password) {
        doctor.password = await bcrypt.hash(doctor.password, 10);  // Encrypt password
      }
    },
    beforeUpdate: async (doctor) => {
      if (doctor.password) {
        doctor.password = await bcrypt.hash(doctor.password, 10);  // Encrypt password
      }
    }
  }
});

module.exports = Doctor;
