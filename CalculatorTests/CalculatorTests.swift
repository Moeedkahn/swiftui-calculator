//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Moeed Khan on 29/03/2026.
//

import Testing
@testable import Calculator

struct CalculatorTests {

    @Test func addition() {
        let model = CalculatorModel()
        model.handle(.digit(3))
        model.handle(.operation(.add))
        model.handle(.digit(5))
        model.handle(.equals)
        #expect(model.displayValue == "8")
    }

    @Test func divisionByZero() {
        let model = CalculatorModel()
        model.handle(.digit(9))
        model.handle(.operation(.divide))
        model.handle(.digit(0))
        model.handle(.equals)
        #expect(model.displayValue == "Error")
    }

    @Test func chainedOperations() {
        let model = CalculatorModel()
        model.handle(.digit(3))
        model.handle(.operation(.add))
        model.handle(.digit(4))
        model.handle(.operation(.multiply))
        model.handle(.digit(2))
        model.handle(.equals)
        #expect(model.displayValue == "14")
    }

    @Test func percentage() {
        let model = CalculatorModel()
        model.handle(.digit(5))
        model.handle(.digit(0))
        model.handle(.percent)
        #expect(model.displayValue == "0.5")
    }

    @Test func toggleSign() {
        let model = CalculatorModel()
        model.handle(.digit(7))
        model.handle(.toggleSign)
        #expect(model.displayValue == "-7")
        model.handle(.toggleSign)
        #expect(model.displayValue == "7")
    }

    @Test func decimalInput() {
        let model = CalculatorModel()
        model.handle(.digit(1))
        model.handle(.decimal)
        model.handle(.digit(5))
        #expect(model.displayValue == "1.5")
    }

    @Test func clearResetsState() {
        let model = CalculatorModel()
        model.handle(.digit(9))
        model.handle(.operation(.add))
        model.handle(.digit(3))
        model.handle(.clear)
        #expect(model.displayValue == "0")
    }

    @Test func threeNumberChain() {
        let model = CalculatorModel()
        model.handle(.digit(2))
        model.handle(.operation(.add))
        model.handle(.digit(3))
        model.handle(.operation(.add))
        model.handle(.digit(4))
        model.handle(.equals)
        #expect(model.displayValue == "9")
    }
}
