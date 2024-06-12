//
//  GameModel.swift
//  Edutainment
//
//  Created by Tim Matlak on 04/06/2024.
//

import SwiftUI

@Observable
final class GameModel {
    var numberSelectionFrom = 2
    var numberSelectionTo = 12
    var numberFrom = Array(2...12)
    var numberTo = Array(2...12)
    
    var answer = ""
    var randomElementFrom = 0
    var randomElementTo = 0
    var correctAnswer = 0
    
    var showingResult = false
    var showingCorrectWrong = false
    var isCorrect = false
    
    var userScore = 0
    var numberOfRounds = 0
    var numberOfQuestions = 2
    var answeredQuestions = 0
    var questions = Array(2...22)
    
    var path = NavigationPath()
}
