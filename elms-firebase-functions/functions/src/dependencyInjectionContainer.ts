import { Container } from "inversify";
import { Config } from "./config";
import { CourseEntityMapper } from "./courseManagement/data/mapper/courseEntityMapper";
import { CourseManagementRepositoryImpl } from "./courseManagement/data/repository/courseManagementRepositoryImpl";
import { CourseManagementFirestoreWrapper } from "./courseManagement/data/wrapper/courseManagementFirestoreWrapper";
import { CourseManagementRepository } from "./courseManagement/domain/repository/courseManagementRepository";
import { GetAllAvailableCoursesUsecase } from "./courseManagement/domain/usecases/getAllAvailableCoursesUsacse";
import { StudentCourseInfoEntityMapper } from "./studentManagment/data/mapper/studentCourseInfoEntityMapper";
import { StudentManagementRepositoryImpl } from "./studentManagment/data/repository/studentManagementRepositoryImpl";
import { StudentManagementFirestoreWrapper } from "./studentManagment/data/wrapper/studentManagementFirestoreWrapper";
import { StudentManagementRepository } from "./studentManagment/domain/repository/studentManagementRepository";
import { GetStudentRegisteredAllCourseInfoUsecase } from "./studentManagment/domain/usecases/getStudentRegisteredAllCourseInfoUsecase";
import { GetYetToBeRegisterdCoursesForStudentUsecase } from "./studentManagment/domain/usecases/getYetTobeRegisteredCoursesForStudentUsecase";

export const container = new Container();


container.bind<Config>(Config).toSelf().inSingletonScope()



//// Student Management
/// Domain
// Usecases
container.bind<GetStudentRegisteredAllCourseInfoUsecase>(GetStudentRegisteredAllCourseInfoUsecase).toSelf()
container.bind<GetYetToBeRegisterdCoursesForStudentUsecase>(GetYetToBeRegisterdCoursesForStudentUsecase).toSelf()
/// Data
//Mapper
container.bind<StudentCourseInfoEntityMapper>(StudentCourseInfoEntityMapper).toSelf()
//Wrappers
container.bind<StudentManagementFirestoreWrapper>(StudentManagementFirestoreWrapper).toSelf()
container.bind<StudentManagementRepository>('StudentManagementRepository').to(StudentManagementRepositoryImpl).inSingletonScope();


////Course Management
/// Domain
// Usecases
container.bind<GetAllAvailableCoursesUsecase>(GetAllAvailableCoursesUsecase).toSelf()
/// Data
//Mapper
container.bind<CourseEntityMapper>(CourseEntityMapper).toSelf()
//Wrappers
container.bind<CourseManagementFirestoreWrapper>(CourseManagementFirestoreWrapper).toSelf()
container.bind<CourseManagementRepository>('CourseManagementRepository').to(CourseManagementRepositoryImpl).inSingletonScope();

