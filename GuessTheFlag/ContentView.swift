//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Djroton Noé SOSSOU on 24/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var numQuestionsMax = 0
    
    func flagTapped(_ number: Int) {
        if (numQuestionsMax < 8) {numQuestionsMax += 1}
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
        } else {
            if (score > 0) {score -= 1}
            scoreTitle = "Wrong! That’s the flag of \(countries[correctAnswer])"
        }
        if(numQuestionsMax == 8 ) {
            showingFinalScore = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion () {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        askQuestion()
        showingScore = false
        showingFinalScore = false
        scoreTitle = ""
        score = 0
        numQuestionsMax = 0
    }
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 20){
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.white)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.white)
                    }
                    
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.rect(cornerRadius: 10))
                                .shadow(radius: 5)
                        }
                        
                    }
                }
                
                Spacer()
                Spacer()
                
                Text("Score : \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Image(countries[correctAnswer])
            Button("Continue", action: askQuestion)
        }
        
        .alert("Final Score", isPresented: $showingFinalScore) {
            Button("Restart", action: reset)
        }
    }
}
