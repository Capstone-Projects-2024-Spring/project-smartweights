//
//  CustomProgressView.swift
//  SmartWeights
//
//  Created by par chea on 2/23/24.
//

import SwiftUI

/// A custom progress view that displays the progress value and label.
struct CustomProgressView: View {
    var value: Float // Current progress value
    var maxValue: Float // Maximum progress value to calculate the percentage
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
            let percentageValue = (value / maxValue) * 100
            return String(format: "%.0f%%", percentageValue)
        case .rawValue:
            let rawValue = value * maxValue // Assuming value is a fraction of the maxValue
            return "\(Int(rawValue))/\(Int(maxValue))"
        }
    }
    
    /// The text color based on value for health bar.
    private var textColor: Color {
        if label.lowercased() == "health" && value <= (0.25 * maxValue) {
            return .red
        } else {
            return foregroundColor
        }
    }
    
    var body: some View {
        VStack {
            Text("\(label) (\(displayValue))")
                .bold()
                .foregroundColor(textColor)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width , height: 20)
                        .opacity(0.3)
                        .foregroundColor(backgroundColor)
                    
                    Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: 20)
                        .foregroundColor(foregroundColor)
                        .animation(.linear, value: value)
                }
                .cornerRadius(45.0)
            }
        }
    }
}
