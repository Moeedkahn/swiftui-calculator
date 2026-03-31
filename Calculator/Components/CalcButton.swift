//
//  CalcButton.swift
//  Calculator
//
//  Created by Moeed Khan on 30/03/2026.
//

import SwiftUI

struct CalcButtonView: View {
    let button: CalcButton
    let label:  String
    let isWide: Bool
    let action: () -> Void
    private let impact = UIImpactFeedbackGenerator(style: .light)

    init(_ button: CalcButton,
         label: String,
         wide: Bool = false,
         action: @escaping () -> Void) {
        self.button = button
        self.label  = label
        self.isWide = wide
        self.action = action
    }

    var body: some View {
        Button(action: {
            impact.impactOccurred()
            action()
        }) {
            Text(label)
                .font(.system(size: 22, weight: .regular, design: .rounded))
                .frame(width: isWide ? 156 : 72, height: 72)
                .background(backgroundColor)
                .foregroundStyle(foregroundColor)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }

    private var backgroundColor: Color {
        switch button {
        case .operation, .equals:
            return .orange
        case .clear, .toggleSign, .percent:
            return Color(.systemGray4)
        default:
            return Color(.systemGray2)
        }
    }

    private var foregroundColor: Color {
        switch button {
        case .operation, .equals: return .white
        default: return .primary
        }
    }
}
