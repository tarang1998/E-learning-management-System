import * as ActionTypes from './actionTypes';

export const unregisteredCourses = (state = {
        isLoading: true,
        errMess: null,
        unregisteredCourses: []
    }, action) => {
    switch(action.type) {
        case ActionTypes.ADD_UNREGISTERED_COURSES:
            return {...state, isLoading: false, errMess: null, unregisteredCourses: action.payload};

        case ActionTypes.UNREGISTERED_COURSES_LOADING:
            return {...state, isLoading: true, errMess: null, unregisteredCourses: []};

        case ActionTypes.UNREGISTERED_COURSES_FAILED:
            return {...state, isLoading: false, errMess: action.payload, unregisteredCourses: []};

        default:
            return state;
    }
}