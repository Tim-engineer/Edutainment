//
//  GameView.swift
//  Edutainment
//
//  Created by Tim Matlak on 04/06/2024.
//

import SwiftUI

struct GameView: View {
    
    @Bindable var model: GameModel
    
    var body: some View {
        VStack {
            VStack {
                Button { } label: {
                    VStack {
                        Text("User Score:")
                        Text("\(model.userScore) / \(model.numberOfQuestions * 100)")
                    }
                }
                
                Button { } label: {
                    VStack {
                        Text("Questions answered:")
                        Text("\(model.answeredQuestions) / \(model.numberOfQuestions)")
                    }
                }
            }
            .padding(.horizontal)
            .buttonStyle(.bordered)
            .tint(.blue)
            
            Spacer()
            
            Text("\(model.randomElementFrom) x \(model.randomElementTo) = ?")
                .font(.system(size: 32))
            
            Spacer()
            
            TextField("Answer", text: $model.answer)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .font(.system(size: 44))
                .padding(.bottom)
            
            Button {
                checkAnswer()
                model.showingResult.toggle()
                addNumbers()
            } label: {
                Text("Submit")
            }
            
            Spacer()
            
        }
        .onAppear { generateQuestion() }
        .onSubmit {
            model.showingResult.toggle()
            checkAnswer()
            addNumbers()
        }
        .sheet(isPresented: $model.showingResult) {
            VStack {
                if model.isCorrect {
                    CorrectView(generateQuestion: generateQuestion)
                } else {
                    WrongGameView(generateQuestion: generateQuestion)
                }
            }
            .presentationDetents([.height(180)])
        }
        .sheet(isPresented: $model.showingCorrectWrong) {
            VStack {
                Text("Yayyy!")
                    .font(.largeTitle)
                    .foregroundStyle(.green)
                    .padding(.top, 44)
                Spacer()
                Text("This is the end of the game...")
                Spacer()
                Text("Your score is:")
                Button { } label: {
                    VStack {
                        Text("\(model.userScore) / \(model.numberOfQuestions * 100)")
                    }
                }
                .tint(.blue)
                Spacer()
                Button {
                    model.showingResult.toggle()
                    model.showingCorrectWrong.toggle()
//                    path.removeAll()
                } label: {
                    Text("Back")
                }
            }
            .buttonStyle(.bordered)
        }
        .navigationTitle("Game")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .modifier(FontModifier())
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
    
    func addNumbers() {
        if model.answeredQuestions <= (model.numberOfQuestions - 2) {
            if model.isCorrect {
                model.userScore += 100
            }
            model.answeredQuestions += 1
        } else {
            if model.isCorrect {
                model.userScore += 100
            }
            model.answeredQuestions += 1
            model.showingCorrectWrong.toggle()
        }
    }
}

#Preview {
    NavigationStack {
        GameView(model: GameModel())
    }
}
