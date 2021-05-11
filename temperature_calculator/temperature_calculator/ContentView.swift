//
//  ContentView.swift
//  temperature_calculator
//
//  Created by Borja Saez de Guinoa Vilaplana on 11/5/21.
//

import SwiftUI

struct ContentView: View {
    
    let tempUnits : [UnitTemperature] = [.celsius, .kelvin, .fahrenheit]
    
    @State var originTemp: String = ""
    
    @State private var selectedInputUnit: UnitTemperature = .celsius
    @State private var selectedOutputUnit: UnitTemperature = .celsius
    
    
    private var resultTemperature: String {
        
        guard let value = Double(originTemp) else { return "Enter the temperature" }
        
        let inputUnitAndValue = Measurement.init(value: value, unit: selectedInputUnit)
        
        let output = inputUnitAndValue.converted(to: selectedOutputUnit)
        
        let formattedValue = String(format: "Temperature: %.1f", output.value)
        
        return "\(formattedValue)\(output.unit.symbol)"
    }
    
    
    var body: some View {
        
        NavigationView{
            Form{
                
                Section(header: Text("Enter the temperature")) {
                    TextField("Temp", text: $originTemp)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Input Unit")) {
                    Picker("Input unit", selection: $selectedInputUnit) {
                        ForEach(tempUnits, id: \.self, content: {
                            Text($0.symbol)
                        })
                    }
                }
                
                Section(header: Text("Output Unit")) {
                    Picker("Output unit", selection: $selectedOutputUnit) {
                        ForEach(tempUnits, id: \.self, content: {
                            Text($0.symbol)
                        })
                    }
                }
                
                Section(header: Text("Result")) {
                    Text(resultTemperature)
                }
            }
            .navigationBarTitle("Temperature calculator")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
