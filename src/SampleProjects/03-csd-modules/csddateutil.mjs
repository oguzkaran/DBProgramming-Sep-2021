import {randomInt} from "./csdrandomutil.mjs";

const daysOfMonths = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

const isValidForBounds = (val, min, max) => min <= val && val <= max

const isValidHour = val => isValidForBounds(val, 0, 23)

const isValidMinute = val => isValidForBounds(val, 0, 59)

const isValidSecond = val => isValidForBounds(val, 0, 59)

const isLeapYear = year => year % 4 === 0 && year % 100 !== 0 || year % 400 === 0

const isValidTime = (hour, minute, second) => isValidHour(hour) && isValidMinute(minute) && isValidSecond(second)

const isValidDate = function (day, month, year) {
    if (day < 1 || day > 31 || month < 1 || month > 11)
        return false

    const days = month === 2 && isLeapYear(year) ? 29 : daysOfMonths[month]

    return day <= days
}

const randomDate = function (minYear, maxYear = minYear) {
    const year = randomInt(minYear, maxYear + 1)
    const month = randomInt(1, 13)
    const day = randomInt(1, month === 2 && isLeapYear(year) ? 29 : daysOfMonths[month])

    return new Date(year, month, day)
}

const randomDateFromCurrent = year => randomDate(new Date().getFullYear())
export {isLeapYear, isValidTime, isValidDate, randomDate, randomDateFromCurrent}
