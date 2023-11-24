import {  injectable } from "inversify";
import { CourseEntity } from "../../../courseManagement/domain/entities/courseEntity";
import { GetAllAvailableCoursesUsecase } from "../../../courseManagement/domain/usecases/getAllAvailableCoursesUsacse";
import { container } from "../../../dependencyInjectionContainer";
import { StudentEnrolledCourseInfoEntity } from "../entities/StudentEnrolledCourseInfoEntity";
import { GetStudentRegisteredAllCourseInfoUsecase } from "./getStudentRegisteredAllCourseInfoUsecase";

@injectable()
export class GetYetToBeRegisterdCoursesForStudentUsecase{

    constructor(

    ){}

    async getYetToBeRegisteredCoursesForStudent(studentId : string ): Promise<CourseEntity[]>{

        const getAllCoursesUsecase : GetAllAvailableCoursesUsecase = container.get(GetAllAvailableCoursesUsecase)

        const getStudentRegisteredAllCourseInfoUsecase : GetStudentRegisteredAllCourseInfoUsecase = container.get(GetStudentRegisteredAllCourseInfoUsecase)


        const allCourses: CourseEntity[] = await getAllCoursesUsecase.getAllAvailableCourses()
        
        const registeredCourses : StudentEnrolledCourseInfoEntity[] = await getStudentRegisteredAllCourseInfoUsecase.getStudentRegisteredAllCoursesInfo(studentId)

        const registeredCourseIds : string[] = []

        registeredCourses.forEach((course ) => {
            registeredCourseIds.push(course.courseId)
        })

        const yetToBeRegisteredCourse : CourseEntity[]= []


        allCourses.forEach((course ) => {


            if (!registeredCourseIds.includes(course.id)){

                yetToBeRegisteredCourse.push(course)

            }


        })


        return yetToBeRegisteredCourse







    }
}