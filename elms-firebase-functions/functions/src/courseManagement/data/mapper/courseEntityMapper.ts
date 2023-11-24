import { injectable } from "inversify";
import { CourseEntity } from "../../domain/entities/courseEntity";


@injectable()
export class CourseEntityMapper {


    map(courseData: { [x: string]: any }): CourseEntity {

        const id: string = courseData["id"]
        const name: string = courseData["name"]
        const description: string = courseData["description"]


        return new CourseEntity(
            id, 
            name, 
            description
        )


    }
}