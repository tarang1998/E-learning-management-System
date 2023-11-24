
// API Req Body Errors 

export class DataNotFoundInReqError extends Error{
    readonly message: string;

    constructor(message : string){
        super();
        this.message = message;
    }
}

export class InvalidDataInReqError extends Error{
    readonly message: string;

    constructor(message : string){
        super();
        this.message = message;
    }
}



export enum StatusCodes{
    SUCCESS = 200,
    BAD_REQUEST = 400,
    UNAUTHORIZED = 401,
    NOT_FOUND = 404,
    INTERNAL_SERVER_ERROR = 500
}