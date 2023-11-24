import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { injectable } from "inversify";
const {Storage} = require('@google-cloud/storage');


export interface ConfigWrapper {
    getFunctions(): typeof functions;
    getFirestore(): FirebaseFirestore.Firestore;
    getAuth(): admin.auth.Auth;
    getFieldValue(): typeof FirebaseFirestore.FieldValue;
    getFieldPath(): typeof FirebaseFirestore.FieldPath;

    checkStorageFileExist(fileName : string) : Promise<boolean>
    readFileFromStorageBucket(filePath : string) : Promise<void>
}

@injectable()
export class Config implements ConfigWrapper{

    private readonly auth: admin.auth.Auth;
    private readonly firestore: FirebaseFirestore.Firestore;
    private readonly storage : any

    private readonly studentsCollection: FirebaseFirestore.CollectionReference;

    private static readonly STORAGE_BUCKET_NAME = ''

    private static readonly STUDENTS_COLLECTION = 'students'


    public constructor() {
        this.auth = admin.auth();
        this.firestore = admin.firestore();
        this.storage = new Storage();
        this.studentsCollection = this.firestore.collection(Config.STUDENTS_COLLECTION);
        
    }

    public async checkStorageFileExist(fileName : string ) : Promise<boolean>{
        const bucket = this.storage.bucket(Config.STORAGE_BUCKET_NAME)
        const file = bucket.file(fileName);

        const result = await file.exists()
        return result[0]
    }

    public async readFileFromStorageBucket(filePath : string) : Promise<any> {


        const bucket = this.storage.bucket(Config.STORAGE_BUCKET_NAME)
        const file = bucket.file(filePath);

        const result = await file.download()
        return result[0]

    }




    public getFunctions(): typeof functions {
        return functions;
    }

    public getAuth(): admin.auth.Auth {
        return this.auth;
    }

    public getFirestore(): FirebaseFirestore.Firestore {
        return this.firestore;
    }

    public getFieldValue(): typeof FirebaseFirestore.FieldValue {
        return admin.firestore.FieldValue;
    }

    public getFieldPath(): typeof FirebaseFirestore.FieldPath {
        return admin.firestore.FieldPath;
    }

    public getFirestoreStudentsCollection() : FirebaseFirestore.CollectionReference { 
        return this.studentsCollection;
    }


}