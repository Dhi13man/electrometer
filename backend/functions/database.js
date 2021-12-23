const admin = require('firebase-admin');
var serviceAccount = JSON.parse(process.env.firebase);

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