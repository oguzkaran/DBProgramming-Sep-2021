import {randomInt} from "./csdrandomutil.mjs";

let concatIfNotStarts = (s1, s2) => s1.startsWith(s2) ? s1 : s2 + s1
let concatIfNotEnds = (s1, s2) => s1.endsWith(s2) ? s1 : s1 + s2

function countString(s1, s2, ignoreCase)
{
    let count = 0

    for (let i = -1; (i = s1.indexOf(s2, i + 1)) !== -1; ++count)
        ;

    return count
}

let countStringIgnoreCase = (s1, s2) => countString(s1.toLowerCase(), s2.toLowerCase())


function randomText(n, text)
{
    let str = ""
    let len = text.length;

    for (let i = 0; i < n; ++i)
        str += text.charAt(randomInt(0, len))

    return str
}

function randomTextTR(n)
{
    return randomText(n, "ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZabcçdefgğhıijklmnoöprsştuüvyz")
}


function randomTextsTR(n, min, max)
{
    let result = [];

    while (n--)
        result.push(randomTextTR(randomInt(min, max)))

    return result
}

function randomTextEN(n)
{
    return randomText(n, "ABCDEFGHIJKLMNOPQRSTUWXVYZabcdefghijklmnopqrstuwxvyz")
}

function randomTextsEN(n, min, max)
{
    let result = [];

    while (n--)
        result.push(randomTextEN(randomInt(min, max)))

    return result
}

export {concatIfNotStarts, concatIfNotEnds, countString, countStringIgnoreCase, randomText, randomTextTR,
    randomTextEN, randomTextsEN, randomTextsTR}
