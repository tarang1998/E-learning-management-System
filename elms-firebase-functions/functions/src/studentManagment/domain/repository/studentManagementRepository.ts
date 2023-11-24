import { StudentEnrolledCourseInfoEntity } from "../entities/StudentEnrolledCourseInfoEntity";


export interface StudentManagementRepository {

    getStudentRegisteredAllCoursesInfo(studentId: string): Promise<StudentEnrolledCourseInfoEntity[]>

   
    
}