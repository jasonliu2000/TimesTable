//
//  GameView.swift
//  Challenge 2
//
//  Created by Jason Liu on 6/27/20.
//  Copyright © 2020 Jason Liu. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var gameQuestions: [[Int]]
    @State var currentQuestion = 0
    @State var userAnswer = ""
    @State var correctAnswer = 0
    @State var showingError = false
    
    var body: some View {
        VStack {
            Text("\(gameQuestions[currentQuestion][0]) x \(gameQuestions[currentQuestion][1]) = ")
                
            TextField("", text: $userAnswer, onCommit: checkAnswer)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(width: 100)
            }
        .alert(isPresented: $showingError) {
            Alert(title: Text("Incorrect!"), message: Text("The answer is \(correctAnswer)"), dismissButton: .default(Text("Ok")) {
                self.nextQuestion()
            })
        }
    }
    
    func checkAnswer() {
        let number1 = gameQuestions[currentQuestion][0]
        let number2 = gameQuestions[currentQuestion][1]
        correctAnswer = number1 * number2
        
        if correctAnswer != Int(userAnswer) {
            showingError = true
        } else {
            nextQuestion()
        }
    }
    
    func nextQuestion() {
        if currentQuestion == (gameQuestions.count - 1) {
            self.presentationMode.wrappedValue.dismiss()
        } else {
            currentQuestion += 1
            userAnswer = ""
        }
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameQuestions: [[Int]]())
    }
}
