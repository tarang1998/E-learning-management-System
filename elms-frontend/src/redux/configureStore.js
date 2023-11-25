import { createStore, combineReducers, applyMiddleware } from 'redux';
import { unregisteredCourses } from './unregisteredCourses';
import thunk from 'redux-thunk';
import logger from 'redux-logger';

export const ConfigureStore = () => {
    const store = createStore(
        combineReducers({
            unregisteredCourses : unregisteredCourses

        }),
        applyMiddleware(thunk, logger)
    );

    return store;
}