import React from "react"
import { Container, Row } from "react-bootstrap"
import { BrowserRouter as Router, Switch, Route } from "react-router-dom"
import { AuthProvider } from "../contexts/authContext"
import Dashboard from "./dashboard"
import ForgotPassword from "./forgotPassword"
import Login from "./login/login"
import Sidebar from "./navbar/sidebar"
import PrivateRoute from "./privateRoute"
import Signup from "./signUp"
import UpdateProfile from "./updateProfile"

function App() {


	return (

		<div className="conatiner">


			<AuthProvider>

				<Router>
					<div className="row">

						<div class="col-sm-1">
							<Sidebar />
						</div>
						<div class="col-sm-11">
							<Switch>
								<PrivateRoute exact path="/dashboard" component={Dashboard} />
								<PrivateRoute path="/update-profile" component={UpdateProfile} />
								<Route path="/signup" component={Signup} />
								<Route path="/login" component={Login} />
								<Route path="/forgot-password" component={ForgotPassword} />
							</Switch>
						</div>


					</div>




				</Router>
			</AuthProvider>




		</div >
	)
}

export default App