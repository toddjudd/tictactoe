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
        UIView.animate(withDuration: 4.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 30.0, options: UIViewAnimationOptions.curveEaseIn, animations: ({
            self.playAgainButtion.center.x = self.view.frame.width / 2
        }), completion: nil)
        output.center.x = self.view.frame.width + 30
        UIView.animate(withDuration: 4.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 30.0, options: UIViewAnimationOptions.curveEaseIn, animations: ({
            self.output.center.x = self.view.frame.width / 2
        }), completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var activePlayer = 1
    var gameIsActive = false
    var crossScore = 0
    var noughtScore = 0
    var boardScore = 0
    var wins = [7, 56, 448, 73, 146, 292, 273, 84]
    var buttonTags = [1, 2, 4, 8, 16, 32, 64, 128, 256]
    
    

    @IBOutlet var buttonImage: UIButton!
    @IBOutlet var playAgainButtion: UIButton!
    @IBOutlet var output: UILabel!
    @IBOutlet var gameBoard: UIImageView!
    @IBAction func action(_ sender: AnyObject)
    {
        let image: UIImage? = sender.image
        print("\(sender.tag!) Button pushed SenderImage:\(sender.image)")
        print("gameIsActive:")
        print(gameIsActive)
        print("sender.image == nil")
        print(image == nil)
        //check if game is active and space is ocupied!!
        if gameIsActive && image == nil{
            print("Game is active and sender.image is = to nill")
            if activePlayer == 1 {
                //add score to cross
                crossScore += sender.tag
                //keep track of board
                boardScore += sender.tag
                //animate cross image showing
                UIView.animate(withDuration: 2, animations: {
                    sender.setImage(UIImage(named: "Cross"), for: UIControlState())
                })
                //set active player
                activePlayer = 2
            } else {
                //add score to cross
                noughtScore += sender.tag
                //keep track of board
                boardScore += sender.tag
                //animate cross image showing
                UIView.animate(withDuration: 2, animations: {
                    sender.setImage(UIImage(named: "Nought"), for: UIControlState())
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
                crossScore = 0
                noughtScore = 0
                boardScore = 0

                playAgainButtion.isHidden = false
                playAgainButtion.setTitle("Play Again", for: UIControlState())
            }
            if ((wins[i] & noughtScore) == wins[i]) {
                //owins
                output.text = "O's Won"
                crossScore = 0
                noughtScore = 0
                boardScore = 0
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
                crossScore = 0
                noughtScore = 0
                boardScore = 0
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
        for i in 0..<buttonTags.count {
            let button = view.viewWithTag(buttonTags[i]) as! UIButton
            button.setImage(nil, for: UIControlState())
        }
        
    }
}

