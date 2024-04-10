//
//  CustomProgressView.swift
//  SmartWeights
//
//  Created by par chea on 2/23/24.
//

import SwiftUI

/// A custom progress view that displays the progress value and label.
struct CustomProgressView: View {
    var value: Int // Current progress value
    var maxValue: Int // Maximum progress value to calculate the percentage
    var label: String
    var displayMode: DisplayMode // Add this line
    var foregroundColor: Color
    var backgroundColor: Color
    
    /// The display mode for the progress value and health bar.
    enum DisplayMode {
        case percentage
        case rawValue
    }
    
    /// The formatted display value based on the display mode.
    private var displayValue: String {
            switch displayMode {
            case .percentage:
                let percentageValue = (value * 100) / maxValue
                return "\(percentageValue)%"
            case .rawValue:
                return "\(value)/\(maxValue)"
            }
        }
    
    /// The text color based on value for health bar.
    private var textColor: Color {
        if label.lowercased() == "health" && value <= (maxValue / 4) { // Assuming maxValue is 100, this checks if health is 25 or less
            return .red
        } else {
            return foregroundColor
        }
    }

    
    var body: some View {
        VStack {
            Text("\(label) \(displayValue)")
                .bold()
                .foregroundColor(textColor)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width, height: 20)
                        .opacity(0.3)
                        .foregroundColor(backgroundColor)
                    
                    // Correct the calculation of the filled portion's width
                    Rectangle().frame(width: min(CGFloat(self.value) / CGFloat(self.maxValue) * geometry.size.width, geometry.size.width), height: 20)
                        .foregroundColor(foregroundColor)
                        // Remove .animation() if it causes any deprecation warning or is not needed
                        .animation(.linear, value: value)
                }
                .cornerRadius(45.0)
            }
        }
    }
}
