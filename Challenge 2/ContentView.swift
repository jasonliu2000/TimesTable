//
//  ContentView.swift
//  Challenge 2
//
//  Created by Jason Liu on 6/20/20.
//  Copyright © 2020 Jason Liu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var dimension = 1
    @State var numberofQuestions = 0
    @State var showGameView = false
    @State var questions: [[Int]] = []
    @State var alert = false
    var numGames = ["1","5","20", "All"]
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Multiplication Table Size")
                        .font(.headline)
                    
                    Stepper(value: $dimension, in: 1...12) {
                        Text("\(dimension) x \(dimension)")
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Number of Questions")
                        .font(.headline)
                    
                    Picker("Number of Questions", selection: $numberofQuestions) {
                        ForEach(0..<numGames.count, id: \.self) {
                            Text("\(self.numGames[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button("Start") {
                    self.questions = []
                    self.prepareGame()
                }
                .sheet(isPresented: $showGameView) {
                    GameView(gameQuestions: self.questions)
                }
                .alert(isPresented: $alert) {
                    Alert(title: Text("The number of questions chosen is too large!"), message: Text("Please rechoose number of questions or increase multiplication table size."), dismissButton: .default(Text("Ok")))
                }
            }
            .navigationBarTitle("Times Table")
        }
    }
    
    func prepareGame() {
        var possibleQuestions: [[Int]] = []
        
        for x in 1...dimension {
            for y in 1...dimension {
                possibleQuestions.append([x,y])
            }
        }
        
        possibleQuestions = possibleQuestions.shuffled()
        
        if numberofQuestions == 3 {
            questions = possibleQuestions
            showGameView = true
        } else {
            // changing the number of games to be played from String to Int
            let x = (Int(numGames[numberofQuestions]) ?? 1) - 1
            
            if x > possibleQuestions.count {
                alert = true
            } else {
                for i in 0...x {
                    questions.append(possibleQuestions[i])
                }
                showGameView = true
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
