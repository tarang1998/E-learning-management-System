import React, { useState } from "react"
import { Card, Button, Alert, Container, Row } from "react-bootstrap"
import { Link, useHistory } from "react-router-dom"
import { useAuth } from "../contexts/authContext"

export default function RegisterCourse() {
  const [error, setError] = useState("")
  const { currentUser, logout } = useAuth()
  const navigate = useHistory()

 


  return (
    <>
    <Container>
      <Row className = "mt-2">
        <h2>Register For Courses</h2>
      </Row>
    </Container>
      
    </>
  )
}