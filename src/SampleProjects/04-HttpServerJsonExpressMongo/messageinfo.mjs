export class MessageInfo {
    constructor(message)
    {
        this.message = message
    }

    toString()
    {
        return JSON.stringify(this)
    }
}
