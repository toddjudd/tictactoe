//
//  ViewController.swift
//  TicTacToe
//
//  Created by David T Judd on 2/8/17.
//  Copyright © 2017 Tracer Tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        playAgainButtion.center.x = self.view.frame.width + 30
        
        UIView.animate(withDuration: 4.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 30.0, options: UIViewAnimationOptions.curveEaseIn, animations: ({
            self.playAgainButtion.center.x = self.view.frame.width / 2
        }), completion: nil)

        output.center.x = self.view.frame.width - 300
        
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
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

    @IBOutlet var buttonImage: UIButton!
    @IBOutlet var playAgainButtion: UIButton!
    @IBOutlet var output: UILabel!
    @IBOutlet var gameBoard: UIImageView!
    @IBAction func action(_ sender: AnyObject)
    {
        if gameIsActive && gameState[sender.tag - 1] == 0 {
            if activePlayer == 1 {
                gameState[sender.tag - 1] = activePlayer
                sender.setImage(UIImage(named: "Cross"), for: UIControlState())
                activePlayer = 2
            } else {
                gameState[sender.tag - 1] = activePlayer
                sender.setImage(UIImage(named: "Nought"), for: UIControlState())
                activePlayer = 1
            }
        }
        
        for combination in winningCombinations {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                if gameState[combination[0]] == 1 {
                    output.text = "X's Won"
                } else {
                    output.text = "O's Won"
                }
                gameIsActive = false
                playAgainButtion.isHidden = false
                playAgainButtion.setTitle("Play Again", for: UIControlState())
            }
        }
        
        if gameIsActive {
        
            gameIsActive = false
        
            for index in gameState {
                if index == 0 {
                    gameIsActive = true
                    break
                }
            }
        
            if !gameIsActive {
                output.text = "It's a Draw"
                playAgainButtion.isHidden = false
                playAgainButtion.setTitle("Play Again", for: UIControlState())
            }
        }
        
    }
    @IBAction func playAgain(_ sender: Any) {
        gameIsActive = true
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        activePlayer = 1
        output.text = "Lets's play Tic-Tac-Toe"
        gameBoard.isHidden = false
        playAgainButtion.isHidden = true
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControlState())
        }
        
    }
    
//    func addPulse() {
//        let pulse = Pulsing(numberOfPulses: 1, radius: 110, position: sender.center)
//        pulse.animationDuratione = 0.8
//        pulse.backgroundColor = UIColor.blue.cgColor
//        slef.view.layer.insertSublayey(pulse, Below: sender.layer)
//    }
    
}

