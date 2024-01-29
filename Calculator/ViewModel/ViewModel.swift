//
//  ViewModel.swift
//  Calculator
//
//  Created by User on 29.01.2024.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    // MARK: Property
    @Published var value = "0"
    @Published var number: Double = 0.0
    @Published var currentOperation: Operation = .none
    
    let buttonsArray: [[Buttons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    // MARK: Tap Button Method
    func didTap(item: Buttons) {
        switch item {
        case .plus:
            currentOperation = .addition
            number = Double(value) ?? 0
            value = "0"
        case .minus:
            currentOperation = .subtract
            number = Double(value) ?? 0
            value = "0"
        case .multiple:
            currentOperation = .multiply
            number = Double(value) ?? 0
            value = "0"
        case .divide:
            currentOperation = .divide
            number = Double(value) ?? 0
            value = "0"
        case .equal:
            if let currentValue = Double(value) {
                value = formatResult(performOperation(currentValue))
            }
        case .decimal:
            if !value.contains(".") {
                value += "."
            }
        case .percent:
            if let currentValue = Double(value) {
                value = formatResult(currentValue / 100.0)
            }
        case .negative:
            if let negativeValue = Double(value) {
                value = formatResult(-negativeValue)
            }
        case .clear:
            value = "0"
        default:
            if value == "0" {
                value = item.rawValue
            } else {
                value += item.rawValue
            }
        }
    }
    
    // MARK: Helper Calculate Method
    func performOperation(_ currentValue: Double) -> Double {
        switch currentOperation {
        case .addition:
            return number + currentValue
        case .subtract:
            return number - currentValue
        case .multiply:
            return number * currentValue
        case .divide:
            return number / currentValue
        default:
            return currentValue
        }
    }
    
    // MARK: Remove Last Zero
    func formatResult(_ result: Double) -> String {
        return String(format: "%g", result)
    }
    
    // MARK: Size of Buttons Methods
    func buttonWidth(item: Buttons) -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = 5 * spacing
        let zeroTotalSpacing: CGFloat = 4 * spacing
        let totalColumns: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        
        if item == .zero {
            return (screenWidth - zeroTotalSpacing) / totalColumns * 2
        }
        
        return (screenWidth - totalSpacing) / totalColumns
    }
}
