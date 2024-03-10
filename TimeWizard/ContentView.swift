//
//  ContentView.swift
//  TimeWizard
//
//  Created by Ahsan Qureshi on 3/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var startingUnit = "Seconds"
    @State private var endingUnit = "Seconds"
    @State private var inputTime = 0.0
    
    private let timeUnits = ["Seconds", "Minutes", "Hours", "Days"]
    private let unitConversion = [60, 60, 24, 1]
    private var outputTime: Double {
        var convertedValue = inputTime
        var startingIndex = timeUnits.firstIndex(of: startingUnit) ?? 0
        let endingIndex = timeUnits.firstIndex(of: endingUnit) ?? 0
        while (startingIndex != endingIndex) {
            if (startingIndex > endingIndex) {
                startingIndex -= 1
                convertedValue *= Double(unitConversion[startingIndex])
            } else {
                convertedValue /= Double(unitConversion[startingIndex])
                startingIndex += 1
            }
        }
        return convertedValue
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Starting Unit") {
                    Picker("Starting Unit", selection: $startingUnit) {
                        ForEach(timeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Converted Unit") {
                    Picker("Converted Unit", selection: $endingUnit) {
                        ForEach(timeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Time to convert (\(startingUnit))") {
                    TextField("\(startingUnit)", value: $inputTime, format: .number)
                        .keyboardType(.numberPad)
                }
                Section("Converted time (\(endingUnit))") {
                    Text(outputTime, format: .number)
                }
                
            }
            .navigationTitle("Time Converter")

        }
    }
}

#Preview {
    ContentView()
}
