import { CourseEntity } from "../../../courseManagement/domain/entities/courseEntity";
import { container } from "../../../dependencyInjectionContainer"
import { GetYetToBeRegisterdCoursesForStudentUsecase } from "../../domain/usecases/getYetTobeRegisteredCoursesForStudentUsecase";

export const getUnregisteredCoursesForStudent = async (reqBody :{[x:string]: any}) : Promise<CourseEntity[]> => {


    const studentId : string = reqBody["studentId"]

    const getYetUnregisteredCoursesForStudentUsecase : GetYetToBeRegisterdCoursesForStudentUsecase = container.get(GetYetToBeRegisterdCoursesForStudentUsecase);

    const courseEntity : CourseEntity[]  = await getYetUnregisteredCoursesForStudentUsecase.getYetToBeRegisteredCoursesForStudent(studentId)

    return courseEntity


} 