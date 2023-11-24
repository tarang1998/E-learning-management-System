import {  inject, injectable } from "inversify";
import { container } from "../../../dependencyInjectionContainer";
import { CourseEntity } from "../../domain/entities/courseEntity";
import { CourseManagementRepository } from "../../domain/repository/courseManagementRepository";
import { CourseEntityMapper } from "../mapper/courseEntityMapper";
import { CourseManagementFirestoreWrapper } from "../wrapper/courseManagementFirestoreWrapper";


@injectable()
export class CourseManagementRepositoryImpl implements CourseManagementRepository {

    constructor(
        @inject(CourseManagementFirestoreWrapper) private readonly firestoreWrapper: CourseManagementFirestoreWrapper,

    ) { }


    async getAllAvailableCourses(): Promise<CourseEntity[]> {
        
        const data : {[x: string]: any} = await this.firestoreWrapper.getAllAvailableCourses();

        const courseEntityMapper : CourseEntityMapper =  container.get(CourseEntityMapper)

        const coursesData : CourseEntity[] = []

        data.forEach((element: {[x: string]: any}) => {

            const courseEntity : CourseEntity = courseEntityMapper.map(element);

            coursesData.push(courseEntity)
            
        });


        return coursesData
    }


}