//
//  CorrectWrongView.swift
//  Edutainment
//
//  Created by Tim Matlak on 05/06/2024.
//

import SwiftUI

struct CorrectView: View {
    
    let generateQuestion: () -> Void
    
    var body: some View {
        VStack {
            Button {
                generateQuestion()
            } label: {
                VStack {
                    Text("Correct!")
                        .font(.title)
                    Text("Next Question")
                }
            }
            .buttonStyle(.bordered)
            .tint(.green)
        }
    }
}

struct WrongView: View {
    
    let tryAgain: () -> Void
    let generateQuestion: () -> Void
    
    var body: some View {
        VStack {
            Text("Wrong!")
                .foregroundStyle(.red)
                .font(.title)
            Text("No worries try again or go on to the next question...")
                            .multilineTextAlignment(.center)
                            .font(.headline)
                            .padding(.horizontal, 4)
            HStack {
                Button {
                    tryAgain()
                } label: {
                    Text("Try Again")
                }
                .tint(.green)
                
                Spacer()
                
                Button {
                    generateQuestion()
                } label: {
                    Text("Next Question")
                }
                .tint(.red)
            }
            .buttonStyle(.bordered)
            .padding(.horizontal, 28)
        }
    }
}


struct WrongGameView: View {
    
    let generateQuestion: () -> Void
    
    var body: some View {
        VStack {
            Text("Wrong!")
                .foregroundStyle(.red)
                .font(.title)
            Text("No worries go on to the next question...")
                .multilineTextAlignment(.center)
                .font(.headline)
                .padding(.horizontal, 8)
            
            Button {
                generateQuestion()
            } label: {
                Text("Next Question")
                    .tint(.blue)
            }
            .buttonStyle(.bordered)
        }
    }
}
