export class StudentEnrolledCourseInfoEntity{

    readonly studentId : string 
    readonly courseId : string
    readonly enrolledAt : Date
   

    constructor(
        studentId : string, 
        courseId : string,
        enrolledAt : Date,

        
    ){
        this.studentId = studentId
        this.courseId = courseId,
        this.enrolledAt = enrolledAt
    }


}
