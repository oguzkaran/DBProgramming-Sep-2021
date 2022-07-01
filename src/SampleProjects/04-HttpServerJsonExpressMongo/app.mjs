import {writeErrLine} from '../../../csd-modules/csdstdioutil.mjs'
import {initService} from './initService.mjs';


process.on("uncaughtException", err => writeErrLine(err))


function main()
{
    initService()
}

main()

