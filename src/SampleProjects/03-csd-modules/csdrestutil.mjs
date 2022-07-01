function sendJSONWithStatusCode(code, res, obj)
{
    res.writeHead(code, {'Content-Type' : 'application/json'})
    res.end(`${JSON.stringify(obj)}\r\n`)
}

const sendJSONSuccess = (res, obj) => sendJSONWithStatusCode(200, res, obj)
const sendJSONNotFound = (res, obj) => sendJSONWithStatusCode(404, res, obj)
const sendJSON500 = (res, obj) => sendJSONWithStatusCode(500, res, obj)
const sendJSON400 = (res, obj) => sendJSONWithStatusCode(400, res, obj)

//...

export {sendJSONSuccess, sendJSON500, sendJSONWithStatusCode, sendJSONNotFound, sendJSON400}

