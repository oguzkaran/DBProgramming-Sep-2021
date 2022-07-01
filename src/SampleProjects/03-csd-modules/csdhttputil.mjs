function remoteAddress(req)
{
    const remoteAddress = req.connection.remoteAddress

    return remoteAddress.substring(remoteAddress.lastIndexOf(":") + 1)
}

export {remoteAddress}
