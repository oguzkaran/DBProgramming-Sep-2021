const write = a => process.stdout.write(a)
const writeLine = a => write(a === undefined ? '\n' : `${a}\n`)
const writeErr = a => process.stderr.write(a)
const writeErrLine = a => writeErr(a === undefined ? '\n' : `${a}\n`)
const readLoop = action => process.stdin.on("data", data =>  action(data))

export {write, writeLine, writeErr, writeErrLine, readLoop}


