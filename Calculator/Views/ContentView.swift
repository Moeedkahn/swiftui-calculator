//
//  ContentView.swift
//  Calculator
//
//  Created by Moeed Khan on 30/03/2026.
//

import SwiftUI
struct ContentView: View {
    @State private var model = CalculatorModel()
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 12) {
                Spacer()
                DisplayView(
                    value: model.displayValue,
                    expression: model.expression
                )
                ButtonGridView(model: model)
            }
        }
    }
}
