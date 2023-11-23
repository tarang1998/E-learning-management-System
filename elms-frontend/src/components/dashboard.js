import React, { useState } from "react"
import { Card, Button, Alert } from "react-bootstrap"
import { Link, useHistory } from "react-router-dom"
import { useAuth } from "../contexts/authContext"

export default function Dashboard() {
  const [error, setError] = useState("")
  const { currentUser, logout } = useAuth()
  const navigate = useHistory()

 

  return (
    <>

      Dashboard - Display all the enrolled courses
    </>
  )
}