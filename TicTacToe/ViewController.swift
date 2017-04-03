//
//  ViewController.swift
//  TicTacToe
//
//  Created by David T Judd on 2/8/17.
//  Copyright © 2017 Tracer Tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // this is a test to see how branching works
    override func viewDidLoad() {
        super.viewDidLoad()
        playAgainButtion.center.x = self.view.frame.width + 30
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 30.0, options: UIViewAnimationOptions.curveEaseIn, animations: ({
            self.playAgainButtion.center.x = self.view.frame.width / 2
        }), completion: nil)
        output.center.x = self.view.frame.width + 30
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 30.0, options: UIViewAnimationOptions.curveEaseIn, animations: ({
            self.output.center.x = self.view.frame.width / 2
        }), completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    var activePlayer = 1
    var gameIsActive = false
    var crossScore = 0
    var noughtScore = 0
    var boardScore = 0
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var wins = [7, 56, 448, 73, 146, 292, 273, 84]
    var buttonTags = [1, 2, 4, 8, 16, 32, 64, 128, 256]

    @IBOutlet var buttonImage: UIButton!
    @IBOutlet var playAgainButtion: UIButton!
    @IBOutlet var output: UILabel!
    @IBOutlet var gameBoard: UIImageView!
    @IBAction func action(_ sender: AnyObject)
    {
        //check if game is active and space is ocupied!!
        if gameIsActive && gameState[sender.tag - 1] == 0{
           if activePlayer == 1 {
                //add score to cross
                crossScore += buttonTags[sender.tag - 1]
                //keep track of board
                boardScore += buttonTags[sender.tag - 1]
                //keep track of placement on the board
                gameState[sender.tag - 1] = activePlayer
                //animate cross image showing
                let currentButton = view.viewWithTag(sender.tag) as! UIButton
                currentButton.setImage(UIImage(named: "Cross"), for: UIControlState())
                UIView.animate(withDuration: 0.3, animations: {
                    currentButton.alpha = 1
                })
                //set active player
                activePlayer = 2
            } else {
                //add score to cross
                noughtScore += buttonTags[sender.tag - 1]
                //keep track of board
                boardScore += buttonTags[sender.tag - 1]
                //keep track of placement on the board
                gameState[sender.tag - 1] = activePlayer
                //animate cross image showing
                let currentButton = view.viewWithTag(sender.tag) as! UIButton
                currentButton.setImage(UIImage(named: "Nought"), for: UIControlState())
                UIView.animate(withDuration: 0.3, animations: {
                        currentButton.alpha = 1
                })
                //set active player
                activePlayer = 1
            }
        }
        //check for winner
        for i in 0..<wins.count {
            if ((wins[i] & crossScore) == wins[i]) {
                //xwins
                output.text = "X's Won"
                gameIsActive = false
                resetVarGame()
                playAgainButtion.isHidden = false
                playAgainButtion.setTitle("Play Again", for: UIControlState())
            }
            if ((wins[i] & noughtScore) == wins[i]) {
                //owins
                output.text = "O's Won"
                resetVarGame()
                gameIsActive = false
                playAgainButtion.isHidden = false
                playAgainButtion.setTitle("Play Again", for: UIControlState())
            }
        }
        //check for draw
        if gameIsActive {
            gameIsActive = false
            if boardScore != 511 {
                gameIsActive = true
            }
            if !gameIsActive {
                resetVarGame()
                output.text = "It's a Draw"
                playAgainButtion.isHidden = false
                playAgainButtion.setTitle("Play Again", for: UIControlState())
            }
        }
        
    }
    @IBAction func playAgain(_ sender: Any) {
        gameIsActive = true
        activePlayer = 1
        output.text = "Lets's play Tic-Tac-Toe"
        gameBoard.isHidden = false
        playAgainButtion.isHidden = true
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControlState())
            button.alpha = 0.1
        }
    }
    
    func resetVarGame() {
        crossScore = 0
        noughtScore = 0
        boardScore = 0
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    }
}

