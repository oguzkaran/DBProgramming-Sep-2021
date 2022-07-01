import mongodb from 'mongodb'

const MongoClient = mongodb.MongoClient
const mongoDbOptions = {useNewUrlParser: true, useUnifiedTopology: true}

const createMongoClientByUrl = url => new MongoClient(url, mongoDbOptions)
const createMongoClient = (host, port) => createMongoClientByUrl(`mongodb://${host}:${port}`)

class MongoConnection {
    constructor(host, port)
    {
        this.host = host;
        this.port = port
    }
}

class MongoRepository {
    constructor(connection, dbName, collectionName)
    {
        this._connection = connection
        createMongoClient(this._connection.host, this._connection.port).connect((err, client) => this.createMongoClientCallback(err, client))

        this._dbName = dbName
        this._collectionName = collectionName
    }

    createMongoClientCallback(err, client)
    {
        this._db = client.db(this._dbName)
        this._collection = this._db.collection(this._collectionName)
    }

    save(record)
    {
        this._collection.insertOne(record, err => {if (err) throw err})
    }
    //Other CRUD Operations
}

export {createMongoClientByUrl, createMongoClient, MongoConnection, MongoRepository}


