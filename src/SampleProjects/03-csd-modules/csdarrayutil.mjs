import {randomInt, randomDouble} from "./csdrandomutil.mjs";
import {write, writeLine} from "./csdstdioutil.mjs";

const randomIntArray = (n, min, max) => {
    let result = []

    while (n--)
        result.push(randomInt(min, max))

    return result
}

const randomDoubleArray = (n, min, bound) => {
    let result = []

    while (n--)
        result.push(randomDouble(min, bound))

    return result
}

function writeIntArray()
{
    for (let val of this)
        write(`${val} `)

    writeLine()
}

function multiplyBy(value)
{
    for (let i = 0; i < this.length; ++i)
        this[i] *= value
}

function writeDoubleArray()
{
    for (let val of this)
        writeLine(val)
}

Array.prototype.writeIntArray = writeIntArray
Array.prototype.writeDoubleArray = writeDoubleArray
Array.prototype.multiplyBy = multiplyBy

export {randomIntArray, randomDoubleArray}

