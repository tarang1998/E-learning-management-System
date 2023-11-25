import React, { useRef, useState } from "react"
import { Form, Button, Card, Alert } from "react-bootstrap"
import { Link, useHistory } from "react-router-dom"
import { useAuth } from "../contexts/authContext"
import { Container } from "react-bootstrap"

import { doc, getFirestore, setDoc } from "firebase/firestore"

const db = getFirestore()


export default function Signup() {
    const emailRef = useRef()
    const passwordRef = useRef()
    const passwordConfirmRef = useRef()
    const userName = useRef()
    const { getCurrentUser, signup } = useAuth()
    const [error, setError] = useState("")
    const [loading, setLoading] = useState(false)
    const navigate = useHistory()

    const validateEmail = (email) => {
        return String(email)
            .toLowerCase()
            .match(
                /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
            );
    };

    const createUserRecord = async () => {
        const studentId = getCurrentUser()._delegate.uid;

        const docRef = doc(db, "students", studentId)

        const payload = {
            "id": studentId,
            "name": userName.current.value,
            "email": emailRef.current.value,
            "createdAt": new Date()

        }

        await setDoc(docRef, payload)
    }

    async function handleSubmit(e) {
        e.preventDefault()


        if (!validateEmail(emailRef.current.value)) {
            return setError("Please enter a valid email Id.")
        }

        if (passwordRef.current.value.length < 8) {
            return setError("Length of the password must be greater than 8")
        }

        if (passwordRef.current.value !== passwordConfirmRef.current.value) {
            return setError("Passwords do not match")
        }

        try {
            setError("")
            setLoading(true)
            await signup(emailRef.current.value, passwordRef.current.value)
            await createUserRecord()
            navigate.push("/dashboard")
        }
        catch (error) {

            console.log(error)
            setError("Failed to create an account. Please try again later")
        }

        setLoading(false)
    }

    return (


        <Container
            className="d-flex align-items-center justify-content-center"
            style={{ minHeight: "100vh" }}
        >
            <div
                className="w-100" style={{ maxWidth: "450px" }}
            >
                <Card>
                    <Card.Body>
                        <h2 className="text-center mb-4">Sign Up</h2>
                        {error && <Alert variant="danger">{error}</Alert>}
                        <Form onSubmit={handleSubmit} className="mb-2">
                            <Form.Group id="name">
                                <Form.Label>Name</Form.Label>
                                <Form.Control type="name" ref={userName} required />
                            </Form.Group>
                            <Form.Group id="email" className="mt-2">
                                <Form.Label>Email</Form.Label>
                                <Form.Control type="email" ref={emailRef} required />
                            </Form.Group>
                            <Form.Group id="password" className="mt-2">
                                <Form.Label>Password</Form.Label>
                                <Form.Control type="password" ref={passwordRef} required />
                            </Form.Group>
                            <Form.Group id="password-confirm" className="mt-2">
                                <Form.Label>Password Confirmation</Form.Label>
                                <Form.Control type="password" ref={passwordConfirmRef} required />
                            </Form.Group>
                            <Button disabled={loading} className="w-100 mt-4" type="submit">
                                Sign Up
                            </Button>
                        </Form>
                    </Card.Body>
                </Card>
                <div className="w-100 text-center mt-2">
                    Already have an account? <Link to="/login">Log In</Link>
                </div>

            </div >
        </Container>

    )
}