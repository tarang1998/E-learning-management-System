import { CourseEntity } from "../../../courseManagement/domain/entities/courseEntity";


export interface CourseManagementRepository {

    getAllAvailableCourses( ) : Promise<CourseEntity[]>

   
    
}