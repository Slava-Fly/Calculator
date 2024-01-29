//
//  CalculatorApp.swift
//  Calculator
//
//  Created by User on 29.01.2024.
//

import SwiftUI

@main
struct CalculatorApp: App {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
        }
    }
}
