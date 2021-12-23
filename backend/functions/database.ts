import admin from 'firebase-admin';
var serviceAccount = JSON.parse(process.env.firebase!);

if (!admin.apps.length) {
    try {
        admin.initializeApp({
            credential: admin.credential.cert(serviceAccount),
        });
    } catch (error: any) {
        console.log('Firebase admin initialization error', error.stack);
    }
}

export default admin.firestore;