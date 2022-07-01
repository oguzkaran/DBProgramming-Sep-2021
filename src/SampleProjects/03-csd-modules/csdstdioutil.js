exports.write = a => process.stdout.write(a)
exports.writeLine = a => exports.write(a === undefined ? '\n' : `${a}\n`)
exports.writeLog = a => console.log(a)
exports.writeErr = a => process.stderr.write(a)
exports.writeErrLine = a => writeErr(a === undefined ? '\n' : `${a}\n`)
exports.readLoop = action => process.stdin.on("data", data =>  action(data))

