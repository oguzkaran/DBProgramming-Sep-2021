class Random {
    static nextNumber(min, max) //[min, max)
    {
        return Math.random() * (max - min) + min
    }

    static nextInt(min, max) //[min, max)
    {
        return Math.floor(Random.nextNumber(min, max))
    }

    static nextBoolean()
    {
        return Random.nextInt(0, 2) === 1
    }

    static nextDouble(min, max)
    {
        return this.nextNumber(min, max)
    }
}

export {Random}
