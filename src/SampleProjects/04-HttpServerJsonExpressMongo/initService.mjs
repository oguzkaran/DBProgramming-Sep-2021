import {MessageInfo} from "./messageinfo.mjs";
import {saveAddress} from "./crud.mjs";
import {sendJSONNotFound, sendJSONSuccess, sendJSON400} from '../../../csd-modules/csdrestutil.mjs'
import {writeLine} from '../../../csd-modules/csdstdioutil.mjs'
import express from 'express'

const msgInfo = new MessageInfo("")
const app = express()


function rootUrlCallback(req, res)
{
    msgInfo.message = "Forbidden!..."
    saveAddress(req, req.url, msgInfo.message)
    sendJSON400(res, msgInfo)
}

function helloUrlCallback(req, res)
{
    msgInfo.message = "Hello!..."
    saveAddress(req, req.url, msgInfo.message)
    sendJSONSuccess(res, msgInfo)
}

function helloTRUrlCallback(req, res)
{
    msgInfo.message = "Merhaba arkadaşlar"
    saveAddress(req, req.url, msgInfo.message)
    sendJSONSuccess(res, msgInfo)
}

function helloENUrlCallback(req, res)
{
    msgInfo.message = "Hi friends"
    saveAddress(req, req.url, msgInfo.message)
    sendJSONSuccess(res, msgInfo)
}

function notFoundUrlCallback(req, res)
{
    msgInfo.message = `${req.url} not found`
    saveAddress(req, req.url, msgInfo.message)
    sendJSONNotFound(res, msgInfo)
}

function initService()
{
    const port =  parseInt(process.argv[2])

    writeLine(`Server is listening on port:${port}`)
    app.get('/', (req, res) => rootUrlCallback(req, res))
    app.get('/api/hello', (req, res) => helloUrlCallback(req, res))
    app.get('/api/hello-tr', (req, res) => helloTRUrlCallback(req, res))
    app.get('/api/hello-en', (req, res) => helloENUrlCallback(req, res))
    app.use((req, res) => notFoundUrlCallback(req, res))
    app.listen(port)
}

export {initService}
