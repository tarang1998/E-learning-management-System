import React, { useState, useEffect } from "react"
// import { Card, Button, Alert, Container, Row, CardImg, CardImgOverlay, CardTitle } from "react-bootstrap"
import { Container, Row } from "react-bootstrap"

import { Media } from 'reactstrap';

import { Link, useHistory } from "react-router-dom"
import { Loading } from "./loading";
// import axios from 'axios';

export default function RegisterCourse(props) {
  const navigate = useHistory()

  const coursesData = props.unregisteredCoursesData.unregisteredCourses

  // useEffect(() => {
  //   axios.get(` https://us-central1-elms-88a47.cloudfunctions.net/students/v1/getUnregisteredCoursesForStudent?studentId=${studentId}`)
  //     .then(response => {
  //       console.log(response.data)
  //       setCoursesData(response.data);
  //     })
  //     .catch(error => {
  //       console.error(error);
  //     });

  // }, []);


  function RenderCourse({ course }) {
    return (
      // <Card key={course.id}
      //   // onClick={() => onClick(dish.id)} 
      //   className='mt-3 mb-3'>
      //   <Link to={`/register-course/${course.id}`} >

      //     {/* <CardImg width="100%" src={""} alt={course.name} /> */}
      //     <CardImgOverlay>
      //       <CardTitle>{course.name}</CardTitle>
      //     </CardImgOverlay>
      //   </Link>

      // </Card>

      <Media className='row' >

        {/* <Media left  href = '#' className = 'col-md-2'>
              <Media object src={course.image} alt={course.name} />
          </Media> */}


        <Media body className='col-md-9 '>
          <Media heading>{course.name}</Media>
          <p>{course.description}</p>
        </Media>
        <Link to={`/register-course/${course.id}`} >
          Go to course
        </Link>


      </Media>
    );

  }


  const courses = coursesData.map((course) => {
    return (
      <div key={course.id} className='col-12 col-md-3 m-1'>
        <RenderCourse course={course}
        // onClick = {props.onClick}
        />
      </div>
    )
  });

  if (props.unregisteredCoursesData.isLoading) {
    return (
      <div className="container">
        <div className="row">
          <Loading />
        </div>
      </div>
    );
  }
  else if (props.unregisteredCoursesData.errMess) {
    return (
      <div className="container">
        <div className="row">
          <h4>{props.dishes.errMess}</h4>
        </div>
      </div>
    );
  }
  else
    return (
      <>
        <Container>
          <Row className="mt-3">
            <h2>Register For Courses</h2>
          </Row>
          <Row className="mt-5">
            {courses}
          </Row>

        </Container>

      </>
    );
}


