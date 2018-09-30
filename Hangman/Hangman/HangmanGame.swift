//
//  HangmanGame.swift
//  Hangman
//
//  Created by Sajal Sharma on 9/29/18.
//  Copyright © 2018 iOS DeCal. All rights reserved.
//

import Foundation

struct HangmanGame {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    var incorrectGuesses: [Character]
    var formattedWord: String {
        var guessedWord = ""
        for letter in word.characters {
            if letter == " " {
                guessedWord += " "
            } else if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += " _"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(_ letter: Character) {
        if letter == "_" {
            guessedLetters.append(" ")
            if !word.contains(" ") {
                incorrectGuesses.append(letter)
                incorrectMovesRemaining -= 1
            }
        } else {
             guessedLetters.append(letter)
            if !word.contains(letter) {
                incorrectGuesses.append(letter)
                incorrectMovesRemaining -= 1
            }
        }
    }
    
    func gameOver() -> Bool {
        for letter in word.characters {
            if !guessedLetters.contains(letter) {
                return false
            }
        }
        return true
    }
}
