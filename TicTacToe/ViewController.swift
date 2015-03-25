//
//  ViewController.swift
//  TicTacToe
//
//  Created by Antonio Caravaca Vega on 23/03/15.
//  Copyright (c) 2015 Antonio Caravaca Vega. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var gameModeControl: UISegmentedControl!
    @IBOutlet weak var chooseDifficultyLabel: UILabel!
    @IBOutlet weak var chooseDifficultySlider: UISlider!
    @IBOutlet weak var easyDifficultyLabel: UILabel!
    @IBOutlet weak var mediumDifficultyLabel: UILabel!
    @IBOutlet weak var hardDifficultyLabel: UILabel!
    
    //MARK: - Variables
    
    var isFirstTurn = true
    var turn = 1
    var winner = 0
    var plays = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.chooseDifficultyLabel.hidden = true
        self.chooseDifficultySlider.hidden = true
        self.easyDifficultyLabel.hidden = true
        self.mediumDifficultyLabel.hidden = true
        self.hardDifficultyLabel.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: - IBActions
    
    @IBAction func newGameButtonPressed() {
        self.isFirstTurn = true
        self.turn = 1
        self.winner = 0
        self.plays = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        self.button1.setImage(nil, forState: UIControlState.Normal)
        self.button2.setImage(nil, forState: UIControlState.Normal)
        self.button3.setImage(nil, forState: UIControlState.Normal)
        self.button4.setImage(nil, forState: UIControlState.Normal)
        self.button5.setImage(nil, forState: UIControlState.Normal)
        self.button6.setImage(nil, forState: UIControlState.Normal)
        self.button7.setImage(nil, forState: UIControlState.Normal)
        self.button8.setImage(nil, forState: UIControlState.Normal)
        self.button9.setImage(nil, forState: UIControlState.Normal)
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        var image = UIImage()
        
        if plays[sender.tag] == 0 {
            if self.isFirstTurn {
                image = UIImage(named: "X.png")!
                plays[sender.tag] = 1
                self.isFirstTurn = false
            }else {
                image = UIImage(named: "O.png")!
                plays[sender.tag] = 2
                self.isFirstTurn = true
            }
            sender.setImage(image, forState: UIControlState.Normal)
            self.turn++
            println(plays)
            checkForWinner()
        }else {
            println("already played that spot")
        }
        
    }
    
    @IBAction func settingsButtonPressed(sender: UIButton) {
        self.settingsView.hidden = false
    }
    
    @IBAction func saveButtonPressed(sender: UIButton) {
        self.settingsView.hidden = true
    }
    
    @IBAction func gameModeSegmentedControl(sender: UISegmentedControl) {
        switch self.gameModeControl.selectedSegmentIndex {
        case 0:
            self.chooseDifficultyLabel.hidden = true
            self.chooseDifficultySlider.hidden = true
            self.easyDifficultyLabel.hidden = true
            self.mediumDifficultyLabel.hidden = true
            self.hardDifficultyLabel.hidden = true
        case 1:
            self.chooseDifficultyLabel.hidden = false
            self.chooseDifficultySlider.hidden = false
            self.easyDifficultyLabel.hidden = false
            self.mediumDifficultyLabel.hidden = false
            self.hardDifficultyLabel.hidden = false
        default:
            break
        }
    }
    
    //MARK: - Helper Functions
    
    func checkForWinner() {
        for combination in winningCombinations {
            
            if plays[combination[0]] == plays[combination[1]] &&
                plays[combination[0]] == plays[combination[2]] &&
                plays[combination[0]] != 0 {
                    
                    winner = plays[combination[0]]
            }
        }
        
        if self.winner == 1 {
            showAlert("Congratulations", message: "First player has won the game!")
        }else if self.winner == 2 {
            showAlert("Congratulations", message: "Second player has won the game!")
        }else if self.winner == 0 && self.turn == 10 {
            showAlert("Oops", message: "The game is tied!")
        }
    }
    
    func showAlert (title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let newGameAction = UIAlertAction(title: "New Game", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.newGameButtonPressed()}
        
        alert.addAction(newGameAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }



    
}