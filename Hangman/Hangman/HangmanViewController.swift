//
//  HangmanViewController.swift
//  Hangman
//
//  Created by Sajal Sharma on 9/29/18.
//  Copyright © 2018 iOS DeCal. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    @IBOutlet weak var hangmanImageView: UIImageView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var incorrectGuessesLabel: UILabel!
    @IBOutlet var letterButton: [UIButton]!
    
    let incorrectMovesAllowed: Int = 6
    let hangmanPhrases = HangmanPhrases()
    var currentGame: HangmanGame!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        newGame()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.uppercased())
        currentGame.playerGuessed(letter)
        updateGameState()
    }
    
    func newGame() {
        enableLetterButtons()
        currentGame = HangmanGame(word: hangmanPhrases.getRandomPhrase(), incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [" "], incorrectGuesses: [])
        updateGameState()
    }
    
    func enableLetterButtons() {
        for button in letterButton {
            button.isEnabled = true
        }
    }
    
    func updateGameState() {
        updateUI()
        
        if currentGame.incorrectMovesRemaining == 0 || currentGame.gameOver() {
            let alertController = UIAlertController(title: "New Game", message: "The game has ended!", preferredStyle: .alert)
            let newGame = UIAlertAction(title: "Start New Game", style: .default) { (action:UIAlertAction) in
                self.newGame();
            }
            alertController.addAction(newGame)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func updateUI() {
        hangmanImageView.image = UIImage(named: "hangman\(incorrectMovesAllowed - currentGame.incorrectMovesRemaining)")
        
        wordLabel.text = currentGame.formattedWord
        
        if incorrectMovesAllowed == currentGame.incorrectMovesRemaining {
            incorrectGuessesLabel.text = "No incorrect moves yet!"
        } else {
            var wrongLetters = [String]()
            for letter in currentGame.incorrectGuesses {
                wrongLetters.append(String(letter))
            }
            incorrectGuessesLabel.text = "Incorrect moves: " + wrongLetters.joined(separator: ", ")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
