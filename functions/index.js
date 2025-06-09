const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendChatNotification = functions.firestore
  .document('chats/{chatId}/messages/{messageId}')
  .onCreate(async (snap, context) => {
    const messageData = snap.data();
    const recipientId = messageData.receiverId;
    const senderName = messageData.senderName;
    const messageText = messageData.text;

    // Fetch the recipient user's FCM token from Firestore
    const userDoc = await admin.firestore().collection('users').doc(recipientId).get();
    const token = userDoc.data().fcmToken;

    if (!token) {
      console.log('No FCM token for user');
      return null;
    }

    const payload = {
      notification: {
        title: `New message from ${senderName}`,
        body: messageText,
      },
      token: token
    };

    // Send the notification
    return admin.messaging().send(payload)
      .then((response) => {
        console.log("Notification sent successfully:", response);
      })
      .catch((error) => {
        console.error("Error sending notification:", error);
      });
  });
