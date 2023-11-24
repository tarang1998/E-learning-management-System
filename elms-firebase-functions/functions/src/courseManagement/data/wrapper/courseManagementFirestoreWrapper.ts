import { inject, injectable } from "inversify";
import { Config } from "../../../config";

@injectable()
export class CourseManagementFirestoreWrapper {

    constructor(
        @inject(Config) private readonly config: Config,
    ) { }

    async getAllAvailableCourses(): Promise<{ [x: string]: any }[]> {


        const query = await this.config.getFirestore()
            .collection("courses")
            .get()


        const data: { [x: string]: any }[] = []



        query.docs.forEach((doc) => {

            data.push(doc.data())

        })


        return data
    }

}

    
