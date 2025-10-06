//
//  ContentView.swift
//  WeSplit
//
//  Created by AMTK on 2025/09/09.
//

import SwiftUI

struct ContentView: View {
    //    let students = ["Harry", "Hermione", "Ron"]
    //    @State private var selectedStudent = "Harry"
    //
    //    var body: some View {
    //        NavigationStack {
    //            Form {
    //                Picker("Select your student", selection: $selectedStudent) {
    //                    ForEach(students, id: \.self) {
    //                        Text($0)
    //                    }
    //                }
    //            }
    //            .navigationTitle("Select a Student")
    //        }
    //    }
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people.", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("how much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        //                        ForEach(tipPercentages, id: \.self) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                
                
                Section("amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("total") {
                    Text(checkAmount + (checkAmount / 100 * Double(tipPercentage)), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .primary)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
