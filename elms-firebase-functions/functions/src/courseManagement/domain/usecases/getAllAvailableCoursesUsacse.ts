import { inject, injectable } from "inversify";
import { CourseEntity } from "../entities/courseEntity";
import { CourseManagementRepository } from "../repository/courseManagementRepository";

@injectable()
export class GetAllAvailableCoursesUsecase{

    constructor(
        @inject("CourseManagementRepository") private readonly courseManagementRepository : CourseManagementRepository,
    ){}

    async getAllAvailableCourses(): Promise<CourseEntity[]>{
        
        const coursesData : CourseEntity[] = await this.courseManagementRepository.getAllAvailableCourses();

        return coursesData;
        
    }
}