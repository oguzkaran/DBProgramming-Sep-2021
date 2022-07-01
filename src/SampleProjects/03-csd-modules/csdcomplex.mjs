const Complex = function (real, imag) {
    this.real = real
    this.imag = imag
}

const createComplex = (real, imag) => new Complex(real === undefined ? 0 : real, imag === undefined ? 0 : imag)

export {Complex, createComplex}
