//
//  DisplayView.swift
//  Calculator
//
//  Created by Moeed Khan on 30/03/2026.
//

import SwiftUI

struct DisplayView: View {
    let value:      String
    let expression: String
    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            Text(expression.isEmpty ? " " : expression)
                .font(.system(size: 28, weight: .regular, design: .rounded))
                .foregroundStyle(Color.white)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Text(value)
                .font(.system(size: fontSize, weight: .regular, design: .rounded))
                .foregroundStyle(Color.white)
                .lineLimit(1)
                .minimumScaleFactor(0.3)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 16)
    }
    private var fontSize: CGFloat {
        switch value.count {
        case ..<7:  return 90
        case ..<10: return 66
        default:    return 48
        }
    }
}
