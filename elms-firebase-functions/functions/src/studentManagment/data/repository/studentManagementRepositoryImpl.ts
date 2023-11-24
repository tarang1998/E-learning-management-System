import {  inject, injectable } from "inversify";
import { container } from "../../../dependencyInjectionContainer";
import { StudentEnrolledCourseInfoEntity } from "../../domain/entities/StudentEnrolledCourseInfoEntity";
import { StudentManagementRepository } from "../../domain/repository/studentManagementRepository";
import { StudentCourseInfoEntityMapper } from "../mapper/studentCourseInfoEntityMapper";
import { StudentManagementFirestoreWrapper } from "../wrapper/studentManagementFirestoreWrapper";


@injectable()
export class StudentManagementRepositoryImpl implements StudentManagementRepository {
    constructor(
        @inject(StudentManagementFirestoreWrapper) private readonly studentManagementFirestoreWrapper: StudentManagementFirestoreWrapper,

    ) { }


    async getStudentRegisteredAllCoursesInfo(studentId: string): Promise<StudentEnrolledCourseInfoEntity[]> {

        const data : {[x: string]: any} = await this.studentManagementFirestoreWrapper.getStudentRegisteredAllCourseInfo(studentId);

        const studentEnrolledCourseEntityMapper : StudentCourseInfoEntityMapper =  container.get(StudentCourseInfoEntityMapper)

        const studentEnrolledCoursesInfo : StudentEnrolledCourseInfoEntity[] = []

        data.forEach((element: {[x: string]: any}) => {

            const courseInfo : StudentEnrolledCourseInfoEntity = studentEnrolledCourseEntityMapper.map(studentId,element);

            studentEnrolledCoursesInfo.push(courseInfo)
            
        });


        return studentEnrolledCoursesInfo
    }

   


}