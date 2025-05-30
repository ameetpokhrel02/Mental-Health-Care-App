const Sequelize = require('sequelize');
const db = require('../config/database');

const Chat = db.define('chats', {
  id: {
    type: Sequelize.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  senderId: {
    type: Sequelize.INTEGER,
    allowNull: false
  },
  receiverId: {
    type: Sequelize.INTEGER,
    allowNull: false
  },
  message: {
    type: Sequelize.TEXT,
    allowNull: false
  },
  isRead: {
    type: Sequelize.BOOLEAN,
    defaultValue: false
  }
}, {
  timestamps: true
});

module.exports = Chat;