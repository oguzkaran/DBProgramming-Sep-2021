function checkForLengthEqual(argv, len, errMessage, exitCode = 1)
{
    if (argv.length !== len) {
        process.stderr.write(errMessage + '\r\n')
        process.exit(exitCode)
    }
}

function checkForLengthGreater(argv, len, errMessage, exitCode = 1)
{
    if (argv.length <= len) {
        process.stderr.write(errMessage + '\r\n')
        process.exit(exitCode)
    }
}

function checkForLengthGreaterOrEqual(argv, len, errMessage, exitCode = 1)
{
    if (argv.length < len) {
        process.stderr.write(errMessage + '\r\n')
        process.exit(exitCode)
    }
}

function checkForLengthLess(argv, len, errMessage, exitCode = 1)
{
    if (argv.length >= len) {
        process.stderr.write(errMessage + '\r\n')
        process.exit(exitCode)
    }
}

function checkForLengthLessOrEqual(argv, len, errMessage, exitCode = 1)
{
    if (argv.length > len) {
        process.stderr.write(errMessage + '\r\n')
        process.exit(exitCode)
    }
}


export {checkForLengthEqual, checkForLengthGreater, checkForLengthGreaterOrEqual, checkForLengthLess, checkForLengthLessOrEqual}
