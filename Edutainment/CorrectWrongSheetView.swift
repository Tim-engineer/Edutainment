//
//  CorrectView.swift
//  Edutainment
//
//  Created by Tim Matlak on 03/06/2024.
//

import SwiftUI

struct CorrectView: View {
    
    let content = ContentView()
    
    var body: some View {
        VStack {
            Text("Correct!")
                .fontWeight(.black)
                .font(.title)
            Text("Next Question")
            .fontWeight(.bold)
        }
    }
}

#Preview {
    CorrectView()
}

struct WrongView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Wrong!")
                    .fontWeight(.black)
                    .font(.title)
            }
            .font(.title)
            .foregroundStyle(.red)
            Text("No worries try again or go on to the next question...")
                .multilineTextAlignment(.center)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    WrongView()
}
