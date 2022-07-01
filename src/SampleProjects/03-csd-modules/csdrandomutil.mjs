const randomInt = (min, max) => parseInt(Math.random() * (max - min)) + min
const randomBoolean = () => randomInt(0, 2) === 1
const randomDouble = (min, bound) => Math.random() * (bound - min) + min
const randomNumber = randomDouble

export {randomInt, randomBoolean, randomDouble, randomNumber}
