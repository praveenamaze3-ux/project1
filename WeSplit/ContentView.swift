//
//  ContentView.swift
//  WeSplit
//
//  Created by Praveen V on 14/06/26.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocussed: Bool
    
    let tipPercentages = [10,15,20,25,0]
    
    var grandtotal: Double {
        let tipselection = Double(tipPercentage)
        
        let tip = checkAmount / 100 * tipselection
        let totalcheck = checkAmount + tip
        return totalcheck
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal/peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }.keyboardType(.decimalPad)
                
                Section("How much tip you want to provide"){
                    Picker("Tip Percentage",selection: $tipPercentage) {
                        ForEach(0..<101,id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                    .padding()
                    .clipped()
                    .frame(height: 180)
                    .background(Color.white.opacity(1))
                    cornerRadius(12)
                }
                
                Section("Total Check(inc.of tip amount)") {
                    Text(grandtotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section ("Amount Per Person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .scrollContentBackground(.hidden)
            .background(Color.yellow.opacity(0.15))
            .toolbar {
                if amountIsFocussed {
                    Button("Done"){
                        amountIsFocussed = false
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
