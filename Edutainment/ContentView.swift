//
//  ContentView.swift
//  Edutainment
//
//  Created by Tim Matlak on 03/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberSelectionFrom = 2
    @State private var numberSelectionTo = 12
    @State private var numberFrom = Array(2...12)
    @State private var numberTo = Array(2...12)
    
    @State private var answer = ""
    @State private var randomElementFrom = 0
    @State private var randomElementTo = 0
    @State private var correctAnswer = 0
    
    @State private var showingResult = false
    @State private var isCorrect = false
    
    @State private var userScore = 0
    @State private var numberOfRounds = 0
    
    var body: some View {
        NavigationStack {
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
                        Picker("To", selection: $numberSelectionTo) {
                            ForEach(numberTo, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }
                }
                .frame(height: 160)
                .pickerStyle(.wheel)
                
                Text("\(randomElementFrom) x \(randomElementTo) = ?")
                
                TextField("Answer", text: $answer)
                    .font(.system(size: 40))
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .onSubmit { showingResult.toggle() }
                    .padding()
                
                Button {
                    showingResult.toggle()
                } label: {
                    Text("Submit")
                }
            }
            .onAppear(perform: generateQuestion)
            .onChange(of: numberSelectionFrom | numberSelectionTo) { generateQuestion() }
            .sheet(isPresented: $showingResult) {
                VStack {
                    if Int(answer) == correctAnswer {
                        VStack {
                            Button {
                                generateQuestion()
                            } label: {
                                CorrectView()
                            }
                            .buttonStyle(.bordered)
                            .tint(.green)
                            HStack {
                                Text("Yes! The correct answer is:")
                                Text("\(correctAnswer)")
                                    .fontWeight(.black)
                                    .foregroundStyle(.green)
                            }
                            .padding(.top, 8)
                            .font(.headline)
                        }
                    } else {
                        VStack {
                            WrongView()
                            HStack {
                                Button {
                                    showingResult = false
                                    answer = ""
                                } label: {
                                    Text("Try Again")
                                }
                                .tint(.green)
                                Spacer()
                                Button(action: generateQuestion) {
                                    Text("Next Question")
                                }
                                .tint(.red)
                            }
                            .buttonStyle(.bordered)
                            .font(.headline)
                            .padding(.horizontal, 32)
                        }
                    }
                }
                .presentationDetents([.height(140)])
            }
            .modifier(FontModifier())
        }
    }
    
    func generateQuestion() {
        let range = numberSelectionFrom...numberSelectionTo
        randomElementFrom = range.randomElement() ?? numberSelectionFrom
        randomElementTo = range.randomElement() ?? numberSelectionTo
        correctAnswer = calculator(from: randomElementFrom, to: randomElementTo)
        answer = ""
        showingResult = false
    }
    
    func checkAnswer() {
        if Int(answer) == correctAnswer {
            isCorrect = true
        } else {
            isCorrect = false
        }
    }
    
    func calculator(from: Int, to: Int) -> Int { from * to }
}

#Preview {
    ContentView()
}

struct FontModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontDesign(.rounded)
            .fontWeight(.heavy)
            .font(.title2)
    }
}

