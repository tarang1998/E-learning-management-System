import { inject, injectable } from "inversify";
import { StudentEnrolledCourseInfoEntity } from "../entities/StudentEnrolledCourseInfoEntity";
import { StudentManagementRepository } from "../repository/studentManagementRepository";

@injectable()
export class GetStudentRegisteredAllCourseInfoUsecase{

    constructor(
        @inject("StudentManagementRepository") private readonly studentManagementRepository : StudentManagementRepository,
    ){}

    async getStudentRegisteredAllCoursesInfo(studentId : string ): Promise<StudentEnrolledCourseInfoEntity[]>{
        
        const data : StudentEnrolledCourseInfoEntity[] = await this.studentManagementRepository.getStudentRegisteredAllCoursesInfo(studentId);

        return data;
        
    }
}