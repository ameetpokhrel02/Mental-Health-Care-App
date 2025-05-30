const WebSocket = require('ws');
const jwt = require('jsonwebtoken');

function setupWebSocket(server) {
  const wss = new WebSocket.Server({ server });

  const clients = new Map();

  wss.on('connection', (ws, req) => {
    const token = req.url.split('=')[1];
    
    try {
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      const userId = decoded.userId;
      
      clients.set(userId, ws);

      ws.on('message', async (message) => {
        const data = JSON.parse(message);
        
        switch(data.type) {
          case 'message':
            const recipientWs = clients.get(data.recipientId);
            if (recipientWs) {
              recipientWs.send(JSON.stringify({
                type: 'message',
                senderId: userId,
                content: data.content,
                timestamp: new Date(),
              }));
            }
            break;
            
          case 'typing':
            const typingWs = clients.get(data.recipientId);
            if (typingWs) {
              typingWs.send(JSON.stringify({
                type: 'typing',
                senderId: userId,
              }));
            }
            break;
        }
      });

      ws.on('close', () => {
        clients.delete(userId);
      });
    } catch (err) {
      ws.terminate();
    }
  });
}

module.exports = setupWebSocket;