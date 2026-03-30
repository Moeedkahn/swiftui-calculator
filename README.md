# iOS Calculator

A clean, modern calculator for iOS built with SwiftUI following 
Apple's recommended MV (Model-View) pattern.

## Screenshots
<!-- Add screenshots here after building -->

## Features
- Basic arithmetic operations
- Chained operations
- Percentage and sign toggle
- Error handling (division by zero)
- Dynamic font sizing on display
- Full expression history shown above result

## Tech Stack
- Swift 5.9
- SwiftUI
- iOS 17+
- @Observable (MV Pattern)
- Swift Testing (Xcode 16)

## Architecture
This project follows Apple's recommended MV pattern introduced 
alongside @Observable in iOS 17. The CalculatorModel holds both 
state and logic and is observed directly by the views — no 
ViewModel layer needed.

## Project Structure
├── Models/
│   └── CalculatorModel.swift    # @Observable model, all logic lives here
├── Views/
│   ├── ContentView.swift        # Root view, owns the model with @State
│   ├── DisplayView.swift        # Expression + result display
│   └── ButtonGridView.swift     # Button grid layout
├── Components/
│   └── CalcButtonView.swift     # Reusable button component
└── Tests/
    └── CalculatorModelTests.swift  # Swift Testing unit tests

## Running the Project
1. Clone the repo
2. Open Calculator.xcodeproj in Xcode 16+
3. Select an iOS 17+ simulator
4. Press Cmd+R to run
