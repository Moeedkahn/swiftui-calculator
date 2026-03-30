//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Moeed Khan on 30/03/2026.
//

import Foundation
import Observation

enum CalcButton: Hashable {
    case digit(Int)
    case decimal
    case operation(Operation)
    case equals
    case clear
    case toggleSign
    case percent

    enum Operation: String {
        case add = "+"
        case subtract = "−"
        case multiply = "×"
        case divide = "÷"
    }
}

@Observable
final class CalculatorModel {

    // MARK: - State
    private(set) var displayValue: String = "0"
    private(set) var expression:   String = ""

    private var currentInput:      String = "0"
    private var previousInput:     String = ""
    private var pendingOperation:  CalcButton.Operation? = nil
    private var justEvaluated:     Bool   = false
    private var waitingForOperand: Bool   = false

    // MARK: - Public interface (called by Views)
    func handle(_ button: CalcButton) {
        switch button {
        case .digit(let n):       inputDigit(n)
        case .decimal:            inputDecimal()
        case .operation(let op):  inputOperation(op)
        case .equals:             evaluate()
        case .clear:              clear()
        case .toggleSign:         toggleSign()
        case .percent:            applyPercent()
        }
        updateDisplay()
    }

    var clearLabel: String {
        currentInput != "0" && !waitingForOperand ? "C" : "AC"
    }

    // MARK: - Private logic
    private func inputDigit(_ n: Int) {
        let digit = String(n)
        if justEvaluated || waitingForOperand {
            currentInput = digit
            justEvaluated = false
            waitingForOperand = false
        } else {
            currentInput = currentInput == "0" ? digit : currentInput + digit
        }
    }

    private func inputDecimal() {
        if justEvaluated || waitingForOperand {
            currentInput = "0."
            justEvaluated = false
            waitingForOperand = false
        } else if !currentInput.contains(".") {
            currentInput += "."
        }
    }

    private func inputOperation(_ op: CalcButton.Operation) {
        if let pending = pendingOperation, !waitingForOperand {
            let result = compute(previousInput, currentInput, op: pending)
            currentInput = format(result)
        }
        previousInput     = currentInput
        pendingOperation  = op
        waitingForOperand = true
        justEvaluated     = false
    }

    private func evaluate() {
        guard let pending = pendingOperation, !waitingForOperand else { return }
        let result = compute(previousInput, currentInput, op: pending)
        expression = "\(formatted(previousInput)) \(pending.rawValue) \(formatted(currentInput)) ="
        currentInput = format(result)
        previousInput = ""
        pendingOperation = nil
        justEvaluated = true
        waitingForOperand = false
    }

    private func clear() {
        currentInput      = "0"
        previousInput     = ""
        pendingOperation  = nil
        justEvaluated     = false
        waitingForOperand = false
        expression        = ""
    }

    private func toggleSign() {
        guard currentInput != "0", currentInput != "Error" else { return }
        currentInput = currentInput.hasPrefix("-")
            ? String(currentInput.dropFirst())
            : "-" + currentInput
    }

    private func applyPercent() {
        guard let n = Double(currentInput) else { return }
        currentInput = format(n / 100)
    }

    // MARK: - Compute
    private func compute(_ a: String, _ b: String,
                         op: CalcButton.Operation) -> Double {
        guard let fa = Double(a), let fb = Double(b) else { return 0 }
        switch op {
        case .add:      return fa + fb
        case .subtract: return fa - fb
        case .multiply: return fa * fb
        case .divide:   return fb == 0 ? .nan : fa / fb
        }
    }

    // MARK: - Formatting
    private func format(_ n: Double) -> String {
        if n.isNaN      { return "Error" }
        if n.isInfinite { return "Error" }
        let rounded = (n * 1e10).rounded() / 1e10
        if rounded == rounded.rounded() && abs(rounded) < 1e12 {
            return String(Int64(rounded))
        }
        return String(rounded)
    }

    private func formatted(_ s: String) -> String {
        guard let n = Double(s) else { return s }
        return format(n)
    }

    private func updateDisplay() {
        displayValue = currentInput
        if let pending = pendingOperation, !justEvaluated {
            expression = "\(formatted(previousInput)) \(pending.rawValue)"
        } else if !justEvaluated {
            expression = ""
        }
    }
}
