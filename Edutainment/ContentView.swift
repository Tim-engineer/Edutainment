//
//  ContentView.swift
//  Edutainment
//
//  Created by Tim Matlak on 03/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var model = GameModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack {
                        Text("From")
                        Picker("From", selection: $model.numberSelectionFrom) {
                            ForEach(model.numberFrom.filter { $0 <= model.numberSelectionTo}, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }
                    VStack {
                        Text("To")
                        Picker("To", selection: $model.numberSelectionTo) {
                            ForEach(model.numberTo.filter { $0 >= model.numberSelectionFrom}, id: \.self) {
                                Text("\($0)")
                            }
                        }
                    }
                }
                .frame(height: 160)
                .pickerStyle(.wheel)
                
                Text("\(model.randomElementFrom) x \(model.randomElementTo) = ?")
                    .font(.title)
                
                TextField("Answer", text: $model.answer)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .font(.system(size: 44))
                    .padding(.bottom)
                
                Button {
                    checkAnswer()
                    model.showingResult.toggle()
                } label: {
                    Text("Submit")
                }
            }
            .padding()
            .onAppear { generateQuestion() }
            .onChange(of: model.numberSelectionFrom | model.numberSelectionTo) { generateQuestion() }
            .onSubmit {
                model.showingResult.toggle()
                checkAnswer()
            }
            .sheet(isPresented: $model.showingResult) {
                VStack {
                    if model.isCorrect {
                        CorrectView(generateQuestion: generateQuestion)
                    } else {
                        WrongView(tryAgain: { model.showingResult.toggle()
                            model.answer = ""
                        }, generateQuestion: generateQuestion)
                    }
                }
                .presentationDetents([.height(180)])
            }
            .navigationTitle("Training")
            .toolbar {
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "play.circle")
                        .frame(width: 44, height: 44)
                }
            }
            .modifier(FontModifier())
        }
    }
    
    func calculator(from: Int, to: Int) -> Int { from * to }
    
    func generateQuestion() {
        let range = model.numberSelectionFrom...model.numberSelectionTo
        model.randomElementFrom = range.randomElement() ?? model.numberSelectionFrom
        model.randomElementTo = range.randomElement() ?? model.numberSelectionTo
        model.correctAnswer = calculator(from: model.randomElementFrom, to: model.randomElementTo)
        model.answer = ""
        model.showingResult = false
    }
    
    func checkAnswer() {
        if Int(model.answer) == model.correctAnswer {
            model.isCorrect = true
            } else {
            model.isCorrect = false
            }
        }
    
    init() {
            UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "SF Pro Rounded", size: 44)!]
        }
}

#Preview {
    ContentView()
}

struct FontModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontDesign(.rounded)
            .font(.title2)
            .fontWeight(.black)
    }
}
