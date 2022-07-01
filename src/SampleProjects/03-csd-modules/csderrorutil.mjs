function subscribe(action, errorAction)
{
    try {
        return action()
    }
    catch (ex) {
        errorAction(ex)
    }
}

function subscribeWithFinally(action, errorAction, finallyAction)
{
    try {
        return action()
    }
    catch (ex) {
        errorAction(ex)
    }
    finally {
        finallyAction()
    }
}

function subscribeJustFinally(action, finallyAction)
{
    try {
        return action()
    }
    finally {
        finallyAction()
    }
}

function exitFail(msg, exitCode = 1)
{
    process.sdterr.write(msg += "\r\n")
    process.exit(exitCode)
}


export {subscribe, subscribeJustFinally, subscribeWithFinally, exitFail}
