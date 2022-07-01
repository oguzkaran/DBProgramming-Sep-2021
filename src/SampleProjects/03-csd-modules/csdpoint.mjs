import {randomInt, randomDouble} from "./csdrandomutil.mjs";

class Point {
    constructor(x = 0,  y = 0)
    {
        this._x = x;
        this._y = y;
    }

    get x()
    {
        return this._x;
    }

    set x(value)
    {
        this._x = value;
    }

    get y()
    {
        return this._y;
    }

    set y(value)
    {
        this._y = value;
    }

    static distance(x1, y1, x2, y2) {return Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))}

    distance(point) {return Point.distance(this._x, this._y, point.x, point.y)}

    offset(dx, dy = dx)
    {
        this._x += dx
        this._y += dy
    }

    toString() {return `{x: ${this._x}, y: ${this._y}}`}
}


const createPoint = (x, y) => new Point(x, y)
const createRandomPoint = (min, bound) => createPoint(randomDouble(min, bound), randomDouble(min, bound))
const createRandomIntPoint = (min, max) => createPoint(randomInt(min, max), randomInt(min, max))
const getOrigin = () => createPoint(0, 0)

export {Point,  createPoint, createRandomPoint, createRandomIntPoint, getOrigin}
