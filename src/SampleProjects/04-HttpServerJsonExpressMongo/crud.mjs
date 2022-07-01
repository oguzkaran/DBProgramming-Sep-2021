import {remoteAddress} from '../../../csd-modules/csdhttputil.mjs'
import {createMongoClient} from '../../../csd-modules/csdmongodbutil.mjs'

function connectForInsertCallback(err, client, req, url, msg)
{
    if (err)
        throw  err

    const db = client.db(process.argv[5])
    const clients = db.collection(process.argv[6])
    const record = {host: remoteAddress(req), time: new Date().toString(), url: url, message: msg}
    clients.insertOne(record, err => {if (err) throw err})
}

function saveAddress(req, url, msg)
{
    const host = process.argv[3]
    const port = parseInt(process.argv[4])
    createMongoClient(host, port).connect((err, client) => connectForInsertCallback(err, client, req, url, msg))
}


export {saveAddress}
