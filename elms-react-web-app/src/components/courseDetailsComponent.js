
import React from 'react';
import {
    Card, CardText, CardBody,
    CardTitle, Breadcrumb, BreadcrumbItem
} from 'reactstrap';

import { Link } from 'react-router-dom';
import { Loading } from './loading';


function RenderCourse({ courseDetail }) {

    return (
        <div className="col-12 col-md-5 m-1 mt-5 mb-5" >
            <Card>
                {/* <CardImg top src={courseDetail.image} alt={courseDetail.name} /> */}
                <CardBody>
                    <CardTitle>{courseDetail.name}</CardTitle>
                    <CardText>{courseDetail.description}</CardText>
                </CardBody>
            </Card>
        </div>
    );

}


const CourseDetailComponent = (props) => {

    console.log(props)

    if (props.isLoading) {
        return (
            <div className="container">
                <div className="row">
                    <Loading />
                </div>
            </div>
        );
    }
    else if (props.errMess) {
        return (
            <div className="container">
                <div className="row">
                    <h4>{props.errMess}</h4>
                </div>
            </div>
        );
    }
    else if (props.course != null)
        return (
            <div className="container">

                <div className="row mt-5">
                    <Breadcrumb>

                        <BreadcrumbItem><Link to="/register-course">Register Courses</Link></BreadcrumbItem>
                        <BreadcrumbItem active>{props.course.name}</BreadcrumbItem>
                    </Breadcrumb>
                    <div className="col-12">
                        <h3>{props.course.name}</h3>
                        <hr />
                    </div>
                </div>

                <div className="row">

                    <RenderCourse courseDetail={props.course} />
                    <br />
                    <Link to={""} >
                        Enroll in Course
                    </Link>
                </div>

            </div>
        );
    else
        return (
            <div></div>
        );
}




export default CourseDetailComponent;