import React, { Component } from "react"
// import { Container, Row } from "react-bootstrap"
import { Switch, Route, withRouter } from "react-router-dom"
import { AuthProvider, useAuth } from "../contexts/authContext"
import Dashboard from "./dashboard"
import ForgotPassword from "./forgotPassword"
import Login from "./login/login"
import Sidebar from "./navbar/sidebar"
import PrivateRoute from "./privateRoute"
import Profile from "./profile"
import RegisterCourse from "./registerCourse"
import Signup from "./signUp"
import UpdateProfile from "./updateProfile"
import { connect } from 'react-redux';
import { fetchUnregisteredCourses } from "../redux/actionCreators"
import CourseDetailComponent from "./courseDetailsComponent"


const mapStateToProps = state => {
	return {
		unregisteredCourses: state.unregisteredCourses
	}
}

const mapDispatchToProps = (dispatch) => ({
	fetchUnregisteredCourses: (studentId) => dispatch(fetchUnregisteredCourses(studentId))

});



class Main extends Component {



	componentDidMount() {


		const studentId = localStorage.getItem('userId');
		this.props.fetchUnregisteredCourses(studentId);

	}

	render() {

		const CourseWithId = ({ match }) => {

			return (
				<CourseDetailComponent
					course={this.props.unregisteredCourses.unregisteredCourses.filter((course) => course.id === match.params.courseId)[0]}
					isLoading={this.props.unregisteredCourses.isLoading}
					errMess={this.props.unregisteredCourses.errMess} />
			);
		};



		return (

			<div className="conatiner">


				<AuthProvider>

					<div className="row">

						<div class="col-sm-1">
							<Sidebar />
						</div>
						<div class="col-sm-11">
							<Switch>
								<PrivateRoute exact path="/" component={Dashboard} />
								<PrivateRoute path="/profile" component={Profile} />
								<PrivateRoute path="/update-profile" component={UpdateProfile} />
								<PrivateRoute exact path="/register-course" component={() => <RegisterCourse unregisteredCoursesData={this.props.unregisteredCourses} />} />
								<PrivateRoute path="/register-course/:courseId" component={CourseWithId} />



								<Route path="/signup" component={Signup} />
								<Route path="/login" component={Login} />
								<Route path="/forgot-password" component={ForgotPassword} />
							</Switch>
						</div>


					</div>




				</AuthProvider>




			</div >
		);

	}

}

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(Main));