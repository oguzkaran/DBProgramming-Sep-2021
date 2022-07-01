class MathError extends Error {
    constructor(message, errorCode)
    {
        super(message)
        this._errorCode = errorCode
    }

    get errorMessage() {return `Message:${this.message}, Error Code:${this._errorCode}`}
    get errorCode() {return this._errorCode}
}


export {MathError}
