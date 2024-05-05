//
//  CustomProgressView.swift
//  SmartWeights
//
//  Created by par chea on 2/23/24.
//

import SwiftUI

/// A custom progress view that displays the progress value, label, and optionally a level.
struct CustomProgressView: View {
    var value: Int // Current progress value
    var maxValue: Int // Maximum progress value to calculate the percentage
    var label: String
    var displayMode: DisplayMode // Determines how the progress is displayed
    var foregroundColor: Color
    var backgroundColor: Color
    var level: Int? // Optional level to display next to XP

    /// The display mode for the progress value.
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
        if label.lowercased() == "health" && value <= (maxValue / 4) {
            return .red // Alerts when health is 25% or less
        } else {
            return foregroundColor
        }
    }

    var body: some View {
        VStack {
            // Constructing the text with level if present, otherwise just the label and values
            if let lvl = level {
                Text("Level \(lvl) | \(label) \(displayValue)")
                    .bold()
                    .foregroundColor(textColor)
            } else {
                Text("\(label): \(displayValue)")
                    .bold()
                    .foregroundColor(textColor)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width, height: 20)
                        .opacity(0.3)
                        .foregroundColor(backgroundColor)

                    Rectangle().frame(width: min(CGFloat(self.value) / CGFloat(self.maxValue) * geometry.size.width, geometry.size.width), height: 20)
                        .foregroundColor(foregroundColor)
                        .animation(.linear, value: value)
                }
                .cornerRadius(45.0)
            }
        }
    }
}
