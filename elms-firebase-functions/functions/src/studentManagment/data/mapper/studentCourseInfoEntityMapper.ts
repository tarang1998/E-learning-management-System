import { injectable } from "inversify";
import { StudentEnrolledCourseInfoEntity } from "../../domain/entities/StudentEnrolledCourseInfoEntity";


@injectable()
export class StudentCourseInfoEntityMapper {


    map(studentId: string, courseInfoData: { [x: string]: any }): StudentEnrolledCourseInfoEntity {

        const courseId: string = courseInfoData["id"]
        const enrolledAt: Date = courseInfoData["enrolledOn"].toDate()


        return new StudentEnrolledCourseInfoEntity(
            studentId,
            courseId,
            enrolledAt
        )


    }
}