const admin = require('firebase-admin');
var serviceAccount = process.env.firebase ? JSON.parse(process.env.firebase) : require('./firebase-service.json');

if (!admin.apps.length) {
    try {
        admin.initializeApp({
            credential: admin.credential.cert(serviceAccount),
        });
    } catch (error) {
        console.log('Firebase admin initialization error', error.stack);
    }
}

module.exports = admin.firestore;