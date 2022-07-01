import EventEmitter from 'events'
import {Random} from "./csdrandom.mjs";
import {isPrime} from "./csdnumberutil.js";

class RandomNumberEmitter extends EventEmitter {
    intervalCallback(timer)
    {
        if (this._count === 0) {
            clearInterval(timer)
            return
        }

        --this._count

        const val = Random.nextInt(this._min, this._max + 1)

        this.emit("value", val)
        if (isPrime(val))
            this.emit("prime", val)

        this.emit(val % 2 === 0 ? "even" : "odd", val)
    }

    constructor(min, max, interval, count)
    {
        super()
        this._min = min
        this._max = max
        this._interval = interval
        this._count = count
    }

    start()
    {
        const timer = setInterval(() => this.intervalCallback(timer), this._interval)
    }
}


export {RandomNumberEmitter}
