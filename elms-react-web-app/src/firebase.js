import firebase from 'firebase/compat/app';
import 'firebase/compat/auth';

const firebaseConfig = {
    apiKey: "AIzaSyC76lH-WJ2XzUQV8OZVtlWcfwONGd1bQVQ",
    authDomain: "elms-88a47.firebaseapp.com",
    projectId: "elms-88a47",
    storageBucket: "elms-88a47.appspot.com",
    messagingSenderId: "407067330546",
    appId: "1:407067330546:web:499cbea40637783c168d6b"

};


const app = firebase.initializeApp(
    firebaseConfig
    //     {
    //   apiKey: process.env.FIREBASE_API_KEY,
    //   authDomain: process.env.FIREBASE_AUTH_DOMAIN,
    //   projectId: process.env.FIREBASE_PROJECT_ID,
    //   storageBucket: process.env.FIREBASE_STORAGE_BUCKET,
    //   messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID,
    //   appId: process.env.FIREBASE_ID
    // }
)


export const auth = app.auth()
export default app