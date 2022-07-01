import EventEmitter from 'events';

export class CountDownTimer extends EventEmitter {
    intervalCallback(timer, msUntilFinished)
    {
        this.emit("tick", this._msFuture)
        this._msFuture -= this._interval
        if (this._msFuture <= 0) {
            clearInterval(timer)
            this.emit("finished")
        }
    }

    constructor(msFuture, interval)
    {
        super();
        this._msFuture = msFuture
        this._interval = interval
    }

    start()
    {
        let msUntilFinished = 0;

        this._timer = setInterval(() => this.intervalCallback(this._timer, msUntilFinished), this._interval)
    }
}
