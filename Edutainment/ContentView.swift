//
//  ContentView.swift
//  Edutainment
//
//  Created by Tim Matlak on 03/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberSelectionFrom = 4
    @State private var numberSelectionTo = 8
    @State private var numberFrom = Array(2...12)
    @State private var numberTo = Array(2...12)
    
    @State private var answer: Int?
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("From")
                    Picker("From", selection: $numberSelectionFrom) {
                        ForEach(numberFrom, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                VStack {
                    Text("To")
                    Picker("From", selection: $numberSelectionTo) {
                        ForEach(numberTo, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
            }
            .frame(height: 160)
            .pickerStyle(.wheel)
            
            TextField("Answer", value: $answer, formatter: NumberFormatter())
                .multilineTextAlignment(.center)
            
        }
        .padding()
        .fontDesign(.rounded)
        .font(.title2)
        .fontWeight(.black)
    }
    
    func calculator(from: Int, to: Int) -> Int { from * to }
    
    
    func dontknowyet() {
        let range = numberSelectionFrom...numberSelectionTo
        let randomElementFrom = range.randomElement()
        let randomElementTo = range.randomElement()
        let correctAnswer = calculator(from: randomElementFrom ?? 0, to: randomElementTo ?? 0)
        
        if correctAnswer == answer { }
    }
    
    func something() {
    
    }
    
}

#Preview {
    ContentView()
}
