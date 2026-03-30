//
//  ButtonGridView.swift
//  Calculator
//
//  Created by Moeed Khan on 30/03/2026.
//

import SwiftUI

struct ButtonGridView: View {
    @Bindable var model: CalculatorModel

    private let buttons: [[CalcButton]] = [
        [.clear, .toggleSign, .percent, .operation(.divide)],
        [.digit(7), .digit(8), .digit(9), .operation(.multiply)],
        [.digit(4), .digit(5), .digit(6), .operation(.subtract)],
        [.digit(1), .digit(2), .digit(3), .operation(.add)],
        [.digit(0), .decimal, .equals]
    ]

    var body: some View {
        VStack(spacing: 12) {
            ForEach(buttons.indices, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(buttons[row], id: \.self) { button in
                        if button == .digit(0) {
                            CalcButtonView(button,
                                           label: "0",
                                           wide: true) {
                                model.handle(button)
                            }
                        } else {
                            CalcButtonView(button,
                                           label: label(for: button)) {
                                model.handle(button)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 32)
    }

    private func label(for button: CalcButton) -> String {
        switch button {
        case .digit(let n):       return "\(n)"
        case .decimal:            return "."
        case .operation(let op):  return op.rawValue
        case .equals:             return "="
        case .clear:              return model.clearLabel
        case .toggleSign:         return "+/−"
        case .percent:            return "%"
        }
    }
}
