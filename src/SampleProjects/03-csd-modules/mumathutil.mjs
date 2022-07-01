import {createRandomPoint} from "./csdpoint.mjs";

const createRandomPoints = (n, min, bound) => {
    if (min >= bound)
        throw new Error()

    let points = []

    while (n--)
        points.push(createRandomPoint(min, bound))

    return points;
}



export {createRandomPoints}

