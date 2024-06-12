//
//  SettingsView.swift
//  Edutainment
//
//  Created by Tim Matlak on 04/06/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var model = GameModel()
    
    var body: some View {
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
            
            Spacer()
            
            NavigationLink {
                GameView(model: model)
            } label: {
                Text("Start")
                    .font(.largeTitle)
            }
            .buttonStyle(.bordered)
            .tint(.green)
            
            Spacer()
            
            Text("Number of Questions")
            Picker("Number of Questions", selection: $model.numberOfQuestions) {
                ForEach(model.questions, id: \.self) {
                    Text("\($0)")
                }
            }
        }
        .pickerStyle(.wheel)
        .padding(.vertical, 40)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .modifier(FontModifier())
    }
    
    init() {
            UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "SF Pro Rounded", size: 22)!]
        }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
