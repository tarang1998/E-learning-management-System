import * as admin from "firebase-admin";
import "reflect-metadata";
import { Config } from "./config";
import { container } from "./dependencyInjectionContainer";
import { StatusCodes } from "./errors";
import { getUnregisteredCoursesForStudent } from "./studentManagment/gateway/getUnregisteredCoursesForStudent/orchestrator";


const express = require('express');
const cookieParser = require('cookie-parser')();
const cors = require('cors')({origin: true});

const studentApi = express();
// const courseApi = express();


admin.initializeApp();  
const config : Config = container.get(Config);
const functions = config.getFunctions();



studentApi.use(cors);
studentApi.use(cookieParser);


studentApi.get('/v1/getUnregisteredCoursesForStudent', async (req: any, res: any) => {
    try{

        const productData : {[x:string] : any} = await getUnregisteredCoursesForStudent(req.query);

        res.status(StatusCodes.SUCCESS).send(productData)

    }
    catch(error){

        functions.logger.error(`Error Occured : ${error}`);

        res.status(StatusCodes.INTERNAL_SERVER_ERROR).send("Server Error. Please contact support")

    }


});


exports.students = functions
.runWith({
  timeoutSeconds: 540,
  memory : "4GB"
  
}).https.onRequest(studentApi);



