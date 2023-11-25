import * as ActionTypes from './actionTypes';



export const fetchUnregisteredCourses = (studentId) => (dispatch) => {

    dispatch(unregisteredCoursesLoading(true));

    return fetch(`https://us-central1-elms-88a47.cloudfunctions.net/students/v1/getUnregisteredCoursesForStudent?studentId=${studentId}`)
        .then(response => {
            if (response.ok) {
                return response;
            }
            else {
                var error = new Error('Error ' + response.status + ': ' + response.statusText);
                error.response = response;
                throw error;
            }
        },
        error => {
            var errmess = new Error(error.message);
            throw errmess;
        })
        .then(response => response.json())
        .then(courses => dispatch(addUnregisteredCourses(courses)))
        .catch(error => dispatch(fetchingUnregisteredCoursesFailed(error.message)));
}

 
export const unregisteredCoursesLoading = () => ({
    type: ActionTypes.UNREGISTERED_COURSES_LOADING
});

export const fetchingUnregisteredCoursesFailed = (errmess) => ({
    type: ActionTypes.UNREGISTERED_COURSES_FAILED,
    payload: errmess
});

export const addUnregisteredCourses = (courses) => ({
    type: ActionTypes.ADD_UNREGISTERED_COURSES,
    payload: courses
});
