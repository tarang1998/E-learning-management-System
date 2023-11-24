import { inject, injectable } from "inversify";
import { Config } from "../../../config";

@injectable()
export class StudentManagementFirestoreWrapper {

    constructor(
        @inject(Config) private readonly config: Config,
    ) { }

    async getStudentRegisteredAllCourseInfo(studentId : string ): Promise<{ [x: string]: any }[]> {


        const query = await this.config.getFirestore()
            .collection("students")
            .doc(studentId)
            .collection("courses")
            .get()


        const data: { [x: string]: any }[] = []

        query.docs.forEach((doc) => {

            data.push({
                "id" : doc.id,
                ...doc.data()
            })

        })

        return data
    }

}

    
