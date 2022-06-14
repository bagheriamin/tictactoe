//
//  SinglePlayerViewController.swift
//  tictactoe
//
//  Created by Amin  Bagheri  on 2022-05-29.
//

import UIKit

class SinglePlayerViewController: UIViewController {
    
    // hard mode boolean value tracker
    var hardModeOn: Bool = false
    
    //image view
    @IBOutlet var imageView: UIImageView!
    
    var gameIsRunning: Bool = true
    var availablePlays = [1,2,3,4,5,6,7,8,9]
    
    // New Game Button
    @IBOutlet var newGame: UIButton!
    
    // settings button
    @IBAction func settingsButtonPressed(_ sender: UIBarButtonItem) {
        slideUpSettingsViewController()
        //setting this view controller to be the intern that will carry out the task that the pverlayviewcontroller ("the boss") wants it to
        selectionDelegate = self
    }
    
    
    
    // X's AND O's
    @IBOutlet var TLImage: UIImageView!
    @IBOutlet var TCImage: UIImageView!
    @IBOutlet var TRImage: UIImageView!
    @IBOutlet var MLImage: UIImageView!
    @IBOutlet var MCImage: UIImageView!
    @IBOutlet var MRImage: UIImageView!
    @IBOutlet var BLImage: UIImageView!
    @IBOutlet var BCImage: UIImageView!
    @IBOutlet var BRImage: UIImageView!
    
    
    // TIC TAC TOE PLAYING BUTTONS
    @IBOutlet var TLButton: UIButton!
    @IBOutlet var TCButton: UIButton!
    @IBOutlet var TRButton: UIButton!
    @IBOutlet var MLButton: UIButton!
    @IBOutlet var MCButton: UIButton!
    @IBOutlet var MRButton: UIButton!
    @IBOutlet var BLButton: UIButton!
    @IBOutlet var BCButton: UIButton!
    @IBOutlet var BRButton: UIButton!
    
    
    // BUTTON STATE VARIABLES:
    var TLOn: Bool = false
    var TCOn: Bool = false
    var TROn: Bool = false
    var MLOn: Bool = false
    var MCOn: Bool = false
    var MROn: Bool = false
    var BLOn: Bool = false
    var BCOn: Bool = false
    var BROn: Bool = false
    
    func resetButtonState() {
        TLOn = false
        TCOn = false
        TROn = false
        MLOn = false
        MCOn = false
        MROn = false
        BLOn = false
        BCOn = false
        BROn = false
    }
    
    // function to show
    @objc func slideUpSettingsViewController() {
        // initialises an instance of the view controller of the settings sliding view
        let slideVC = OverlayViewController()
        // the style is custom
        slideVC.modalPresentationStyle = .custom
        // must have a delegate as we are transitioning from two view controllers
        slideVC.transitioningDelegate = self
        // presents the sliding view controller
        self.present(slideVC, animated: true, completion: nil)
    }
    
    func programaticallySetBoxViews() {
        // setting button BORDER COLORS
        TLButton.layer.borderWidth = 4
        TLButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        TLButton.layer.backgroundColor = UIColor.clear.cgColor
        TLButton.alpha = 1
        TLImage.isHidden = true
        
        TCButton.layer.borderWidth = 4
        TCButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        TCButton.layer.backgroundColor = UIColor.clear.cgColor
        TCButton.alpha = 1
        TCImage.isHidden = true
        
        
        TRButton.layer.borderWidth = 4
        TRButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        TRButton.layer.backgroundColor = UIColor.clear.cgColor
        TRButton.alpha = 1
        TRImage.isHidden = true
        
        
        MLButton.layer.borderWidth = 4
        MLButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        MLButton.layer.backgroundColor = UIColor.clear.cgColor
        MLButton.alpha = 1
        MLImage.isHidden = true
        
        
        MCButton.layer.borderWidth = 4
        MCButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        MCButton.layer.backgroundColor = UIColor.clear.cgColor
        MCButton.alpha = 1
        MCImage.isHidden = true
        
        
        MRButton.layer.borderWidth = 4
        MRButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        MRButton.layer.backgroundColor = UIColor.clear.cgColor
        MRButton.alpha = 1
        MRImage.isHidden = true
        
        
        BLButton.layer.borderWidth = 4
        BLButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        BLButton.layer.backgroundColor = UIColor.clear.cgColor
        BLButton.alpha = 1
        BLImage.isHidden = true
        
        
        BCButton.layer.borderWidth = 4
        BCButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        BCButton.layer.backgroundColor = UIColor.clear.cgColor
        BCButton.alpha = 1
        BCImage.isHidden = true
        
        
        BRButton.layer.borderWidth = 4
        BRButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        BRButton.layer.backgroundColor = UIColor.clear.cgColor
        BRButton.alpha = 1
        BRImage.isHidden = true
    }
    
    // Player Turn Tracker Label
    @IBOutlet var playerTurnTracker: UILabel!
    
    // currentPlayer variable (set to enum)
    var currentPlayer: PlayerTurns
    
    required init?(coder: NSCoder) {
        self.currentPlayer = PlayerTurns.playerX
        super.init(coder: coder)
    }
    
    func hardRobotTurn() {
        if gameIsRunning == true {
            print("Robot is thinking hardly...")
            // calling [self] in explicitly due to typing code in a closure and referecncing utside objects
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
               
                let randomNumber = Int.random(in: 1...10)
                print("Your random number was \(randomNumber)")
                
                // 90% chance of hard code running
                if randomNumber == 1 || randomNumber == 2 || randomNumber == 3 || randomNumber == 4 || randomNumber == 5 || randomNumber == 6 || randomNumber == 7 || randomNumber == 8 {
                    // HARD CODE..
                    // ********************************** HORIZONTAL WINS ********************************** HORIZONTAL WINS **********************************
                    // ********************************** HORIZONTAL WINS ********************************** HORIZONTAL WINS **********************************
                    // ********************************** HORIZONTAL WINS ********************************** HORIZONTAL WINS **********************************
                    if TLOn && TCOn && TLImage.image == UIImage(named: "O") && TCImage.image == UIImage(named: "O") && TROn != true {
                        
                        TROn.toggle()
                        TRImage.image = UIImage(named: "O")
                        TRImage.isHidden = false
                        TRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 3)
                        checkForWinAndUpdateScores()

                    } else if TLOn && TROn && TLImage.image == UIImage(named: "O") && TRImage.image == UIImage(named: "O") && TCOn != true{
                        
                        TCOn.toggle()
                        TCImage.image = UIImage(named: "O")
                        TCImage.isHidden = false
                        TCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 2)
                        checkForWinAndUpdateScores()

                    } else if TCOn && TROn && TCImage.image == UIImage(named: "O") && TRImage.image == UIImage(named: "O") && TLOn != true{
                        
                        TLOn.toggle()
                        TLImage.image = UIImage(named: "O")
                        TLImage.isHidden = false
                        TLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 1)
                        checkForWinAndUpdateScores()

                    } else if MLOn && MCOn && MLImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && MROn != true{
                        
                        MROn.toggle()
                        MRImage.image = UIImage(named: "O")
                        MRImage.isHidden = false
                        MRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 6)
                        checkForWinAndUpdateScores()

                    } else if MLOn && MROn && MLImage.image == UIImage(named: "O") && MRImage.image == UIImage(named: "O") && MCOn != true{
                        
                        MCOn.toggle()
                        MCImage.image = UIImage(named: "O")
                        MCImage.isHidden = false
                        MCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 5)
                        checkForWinAndUpdateScores()

                    } else if MCOn && MROn && MCImage.image == UIImage(named: "O") && MRImage.image == UIImage(named: "O") && MLOn != true{
                        
                        MLOn.toggle()
                        MLImage.image = UIImage(named: "O")
                        MLImage.isHidden = false
                        MLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 4)
                        checkForWinAndUpdateScores()

                    } else if BLOn && BCOn && BLImage.image == UIImage(named: "O") && BCImage.image == UIImage(named: "O") && BROn != true{
                        
                        BROn.toggle()
                        BRImage.image = UIImage(named: "O")
                        BRImage.isHidden = false
                        BRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 9)
                        checkForWinAndUpdateScores()

                    } else if BLOn && BROn && BLImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O") && BCOn != true{
                        
                        BCOn.toggle()
                        BCImage.image = UIImage(named: "O")
                        BCImage.isHidden = false
                        BCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 8)
                        checkForWinAndUpdateScores()

                    } else if BCOn && BROn && BCImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O") && BLOn != true{
                        
                        BLOn.toggle()
                        BLImage.image = UIImage(named: "O")
                        BLImage.isHidden = false
                        BLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 7)
                        checkForWinAndUpdateScores()

                        // ********************************** VERTICAL WINS ********************************** VERTICAL WINS **********************************
                        // ********************************** VERTICAL WINS ********************************** VERTICAL WINS **********************************
                        // ********************************** VERTICAL WINS ********************************** VERTICAL WINS **********************************
                    } else if TLOn && MLOn  && TLImage.image == UIImage(named: "O") && MLImage.image == UIImage(named: "O") && BLOn != true{
                        
                        BLOn.toggle()
                        BLImage.image = UIImage(named: "O")
                        BLImage.isHidden = false
                        BLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 7)
                        checkForWinAndUpdateScores()

                    } else if TLOn && BLOn  && TLImage.image == UIImage(named: "O") && BLImage.image == UIImage(named: "O") && MLOn != true{
                        
                        MLOn.toggle()
                        MLImage.image = UIImage(named: "O")
                        MLImage.isHidden = false
                        MLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 4)
                        checkForWinAndUpdateScores()

                    } else if MLOn && BLOn  && MLImage.image == UIImage(named: "O") && BLImage.image == UIImage(named: "O") && TLOn != true {
                        
                        TLOn.toggle()
                        TLImage.image = UIImage(named: "O")
                        TLImage.isHidden = false
                        TLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 1)
                        checkForWinAndUpdateScores()

                    } else if TCOn && MCOn && TCImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && BCOn != true {
                        
                        BCOn.toggle()
                        BCImage.image = UIImage(named: "O")
                        BCImage.isHidden = false
                        BCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 8)
                        checkForWinAndUpdateScores()

                    } else if TCOn && BCOn && TCImage.image == UIImage(named: "O") && BCImage.image == UIImage(named: "O") && MCOn != true{
                        
                        MCOn.toggle()
                        MCImage.image = UIImage(named: "O")
                        MCImage.isHidden = false
                        MCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 5)
                        checkForWinAndUpdateScores()

                    } else if MCOn && BCOn && MCImage.image == UIImage(named: "O") && BCImage.image == UIImage(named: "O") && TCOn != true{
                        
                        TCOn.toggle()
                        TCImage.image = UIImage(named: "O")
                        TCImage.isHidden = false
                        TCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 2)
                        checkForWinAndUpdateScores()

                    } else if TROn && MROn && TRImage.image == UIImage(named: "O") && MRImage.image == UIImage(named: "O") && BROn != true{
                        
                        BROn.toggle()
                        BRImage.image = UIImage(named: "O")
                        BRImage.isHidden = false
                        BRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 9)
                        checkForWinAndUpdateScores()

                    } else if TROn && BROn && TRImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O") && MROn != true{
                        
                        MROn.toggle()
                        MRImage.image = UIImage(named: "O")
                        MRImage.isHidden = false
                        MRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 6)
                        checkForWinAndUpdateScores()

                    } else if MROn && BROn && MRImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O") && TROn != true{
                        TROn.toggle()
                        TRImage.image = UIImage(named: "O")
                        TRImage.isHidden = false
                        TRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 3)
                        checkForWinAndUpdateScores()

                        // ********************************** DIAGONAL WINS ********************************** DIAGONAL WINS **********************************
                        // ********************************** DIAGONAL WINS ********************************** DIAGONAL WINS **********************************
                        // ********************************** DIAGONAL WINS ********************************** DIAGONAL WINS **********************************
                    } else if TLOn && MCOn && TLImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && BROn != true{
                        
                        BROn.toggle()
                        BRImage.image = UIImage(named: "O")
                        BRImage.isHidden = false
                        BRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 9)
                        checkForWinAndUpdateScores()

                    } else if TLOn && BROn && TLImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O") && MCOn != true{
                        
                        MCOn.toggle()
                        MCImage.image = UIImage(named: "O")
                        MCImage.isHidden = false
                        MCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 5)
                        checkForWinAndUpdateScores()

                    } else if MCOn && BROn && MCImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O") && TLOn != true{
                        
                        TLOn.toggle()
                        TLImage.image = UIImage(named: "O")
                        TLImage.isHidden = false
                        TLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 1)
                        checkForWinAndUpdateScores()

                    } else if TROn && MCOn && TRImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && BLOn != true{
                        
                        BLOn.toggle()
                        BLImage.image = UIImage(named: "O")
                        BLImage.isHidden = false
                        BLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 7)
                        checkForWinAndUpdateScores()

                    } else if TROn && BLOn && TRImage.image == UIImage(named: "O") && BLImage.image == UIImage(named: "O") && MCOn != true{
                        
                        MCOn.toggle()
                        MCImage.image = UIImage(named: "O")
                        MCImage.isHidden = false
                        MCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 5)
                        checkForWinAndUpdateScores()

                    } else if MCOn && BLOn && MCImage.image == UIImage(named: "O") && BLImage.image == UIImage(named: "O") && TROn != true{
                        
                        TROn.toggle()
                        TRImage.image = UIImage(named: "O")
                        TRImage.isHidden = false
                        TRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 3)
                        checkForWinAndUpdateScores()

                        
                        // BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!!
                        // BLOCKING X  BLOCKING X  BLOCKING X  BLOCKING X  BLOCKING X  BLOCKING X  BLOCKING X  BLOCKING X  BLOCKING X  BLOCKING X
                        // BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!!
                        
                    } else if TLOn && TCOn && TLImage.image == UIImage(named: "X") && TCImage.image == UIImage(named: "X") && TROn != true {
                        
                        TROn.toggle()
                        TRImage.image = UIImage(named: "O")
                        TRImage.isHidden = false
                        TRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 3)
                        checkForWinAndUpdateScores()

                    } else if TLOn && TROn && TLImage.image == UIImage(named: "X") && TRImage.image == UIImage(named: "X") && TCOn != true{
                        
                        TCOn.toggle()
                        TCImage.image = UIImage(named: "O")
                        TCImage.isHidden = false
                        TCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 2)
                        checkForWinAndUpdateScores()

                    } else if TCOn && TROn && TCImage.image == UIImage(named: "X") && TRImage.image == UIImage(named: "X") && TLOn != true{
                        
                        TLOn.toggle()
                        TLImage.image = UIImage(named: "O")
                        TLImage.isHidden = false
                        TLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 1)
                        checkForWinAndUpdateScores()

                    } else if MLOn && MCOn && MLImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && MROn != true{
                        
                        MROn.toggle()
                        MRImage.image = UIImage(named: "O")
                        MRImage.isHidden = false
                        MRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 6)
                        checkForWinAndUpdateScores()

                    } else if MLOn && MROn && MLImage.image == UIImage(named: "X") && MRImage.image == UIImage(named: "X") && MCOn != true{
                        
                        MCOn.toggle()
                        MCImage.image = UIImage(named: "O")
                        MCImage.isHidden = false
                        MCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 5)
                        checkForWinAndUpdateScores()

                    } else if MCOn && MROn && MCImage.image == UIImage(named: "X") && MRImage.image == UIImage(named: "X") && MLOn != true{
                        
                        MLOn.toggle()
                        MLImage.image = UIImage(named: "O")
                        MLImage.isHidden = false
                        MLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 4)
                        checkForWinAndUpdateScores()

                    } else if BLOn && BCOn && BLImage.image == UIImage(named: "X") && BCImage.image == UIImage(named: "X") && BROn != true{
                        
                        BROn.toggle()
                        BRImage.image = UIImage(named: "O")
                        BRImage.isHidden = false
                        BRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 9)
                        checkForWinAndUpdateScores()

                    } else if BLOn && BROn && BLImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") && BCOn != true{
                        
                        BCOn.toggle()
                        BCImage.image = UIImage(named: "O")
                        BCImage.isHidden = false
                        BCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 8)
                        checkForWinAndUpdateScores()

                    } else if BCOn && BROn && BCImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") && BLOn != true{
                        
                        BLOn.toggle()
                        BLImage.image = UIImage(named: "O")
                        BLImage.isHidden = false
                        BLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 7)
                        checkForWinAndUpdateScores()

                        // ********************************** VERTICAL WINS ********************************** VERTICAL WINS **********************************
                        // ********************************** VERTICAL WINS ********************************** VERTICAL WINS **********************************
                        // ********************************** VERTICAL WINS ********************************** VERTICAL WINS **********************************
                    } else if TLOn && MLOn  && TLImage.image == UIImage(named: "X") && MLImage.image == UIImage(named: "X") && BLOn != true{
                        
                        BLOn.toggle()
                        BLImage.image = UIImage(named: "O")
                        BLImage.isHidden = false
                        BLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 7)
                        checkForWinAndUpdateScores()

                    } else if TLOn && BLOn  && TLImage.image == UIImage(named: "X") && BLImage.image == UIImage(named: "X") && MLOn != true{
                        
                        MLOn.toggle()
                        MLImage.image = UIImage(named: "O")
                        MLImage.isHidden = false
                        MLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 4)
                        checkForWinAndUpdateScores()

                    } else if MLOn && BLOn  && MLImage.image == UIImage(named: "X") && BLImage.image == UIImage(named: "X") && TLOn != true{
                        
                        TLOn.toggle()
                        TLImage.image = UIImage(named: "O")
                        TLImage.isHidden = false
                        TLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 1)
                        checkForWinAndUpdateScores()

                    } else if TCOn && MCOn && TCImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && BCOn != true{
                        
                        BCOn.toggle()
                        BCImage.image = UIImage(named: "O")
                        BCImage.isHidden = false
                        BCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 8)
                        checkForWinAndUpdateScores()

                    } else if TCOn && BCOn && TCImage.image == UIImage(named: "X") && BCImage.image == UIImage(named: "X") && MCOn != true{
                        
                        MCOn.toggle()
                        MCImage.image = UIImage(named: "O")
                        MCImage.isHidden = false
                        MCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 5)
                        checkForWinAndUpdateScores()

                    } else if MCOn && BCOn && MCImage.image == UIImage(named: "X") && BCImage.image == UIImage(named: "X") && TCOn != true{
                        
                        TCOn.toggle()
                        TCImage.image = UIImage(named: "O")
                        TCImage.isHidden = false
                        TCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 2)
                        checkForWinAndUpdateScores()

                    } else if TROn && MROn && TRImage.image == UIImage(named: "X") && MRImage.image == UIImage(named: "X") && BROn != true{
                        
                        BROn.toggle()
                        BRImage.image = UIImage(named: "O")
                        BRImage.isHidden = false
                        BRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 9)
                        checkForWinAndUpdateScores()

                    } else if TROn && BROn && TRImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") && MROn != true{
                        
                        MROn.toggle()
                        MRImage.image = UIImage(named: "O")
                        MRImage.isHidden = false
                        MRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 6)
                        checkForWinAndUpdateScores()

                    } else if MROn && BROn && MRImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") && TROn != true{
                        TROn.toggle()
                        TRImage.image = UIImage(named: "O")
                        TRImage.isHidden = false
                        TRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 3)
                        checkForWinAndUpdateScores()

                        // ********************************** DIAGONAL WINS ********************************** DIAGONAL WINS **********************************
                        // ********************************** DIAGONAL WINS ********************************** DIAGONAL WINS **********************************
                        // ********************************** DIAGONAL WINS ********************************** DIAGONAL WINS **********************************
                    } else if TLOn && MCOn && TLImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && BROn != true{
                        
                        BROn.toggle()
                        BRImage.image = UIImage(named: "O")
                        BRImage.isHidden = false
                        BRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 9)
                        checkForWinAndUpdateScores()

                    } else if TLOn && BROn && TLImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") && MCOn != true{
                        
                        MCOn.toggle()
                        MCImage.image = UIImage(named: "O")
                        MCImage.isHidden = false
                        MCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 5)
                        checkForWinAndUpdateScores()

                    } else if MCOn && BROn && MCImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") && TLOn != true{
                        
                        TLOn.toggle()
                        TLImage.image = UIImage(named: "O")
                        TLImage.isHidden = false
                        TLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 1)
                        checkForWinAndUpdateScores()

                    } else if TROn && MCOn && TRImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && BLOn != true {
                        
                        BLOn.toggle()
                        BLImage.image = UIImage(named: "O")
                        BLImage.isHidden = false
                        BLButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 7)
                        checkForWinAndUpdateScores()

                    } else if TROn && BLOn && TRImage.image == UIImage(named: "X") && BLImage.image == UIImage(named: "X") && MCOn != true{
                        
                        MCOn.toggle()
                        MCImage.image = UIImage(named: "O")
                        MCImage.isHidden = false
                        MCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 5)
                        checkForWinAndUpdateScores()

                    } else if MCOn && BLOn && MCImage.image == UIImage(named: "X") && BLImage.image == UIImage(named: "X") && TROn != true {
                        
                        TROn.toggle()
                        TRImage.image = UIImage(named: "O")
                        TRImage.isHidden = false
                        TRButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 3)
                        checkForWinAndUpdateScores()
                    } else if MCOn != true {
                        MCOn.toggle()
                        MCImage.image = UIImage(named: "O")
                        MCImage.isHidden = false
                        MCButton.isEnabled = false
                        removeValueFromAvailablePlaysArray(tag: 5)
                        checkForWinAndUpdateScores()
                    } else  {
                        // random play if can't do smart moves
                        print("Normal turn playing because no smart moves were found")
                        hardRandomRobotTurn()
                    }
                    
                    
                } else {
                    // 80% chance of making mistake selected
                    print("80% chance of making mistake selected")
                    hardRandomRobotTurn()
                }
            }
            
            
        }
    }
    
    func checkForWinAndUpdateScores() {
        checkForWin()
        if gameIsRunning {
            toggleAndUpdatePlayerTurns()
            print("switched player in hard turn")
        }
    }
    
    func hardRandomRobotTurn() {
        if gameIsRunning {
            print("Robot is guessing...")
            // Starts code after 3 seconds to make the game seem realistic
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                print("Robot done guessing!")
                
                //pulls a random play fromthe list of available plays
                let randomPlay = availablePlays.randomElement()!
                print(" Square \(randomPlay) was chosen")
                print(availablePlays)
                // gets the first index where that play shows up in the list
                if let firstIndex = availablePlays.firstIndex(of: randomPlay) {
                    // Remove element at that index
                    availablePlays.remove(at: firstIndex)
                }
                
                if randomPlay == 1 {
                    TLOn.toggle()
                    TLImage.image = UIImage(named: "O")
                    TLImage.isHidden = false
                    TLButton.isEnabled = false
                } else if randomPlay == 2 {
                    TCOn.toggle()
                    TCImage.image = UIImage(named: "O")
                    TCImage.isHidden = false
                    TCButton.isEnabled = false
                } else if randomPlay == 3 {
                    TROn.toggle()
                    TRImage.image = UIImage(named: "O")
                    TRImage.isHidden = false
                    TRButton.isEnabled = false
                } else if randomPlay == 4 {
                    MLOn.toggle()
                    MLImage.image = UIImage(named: "O")
                    MLImage.isHidden = false
                    MLButton.isEnabled = false
                } else if randomPlay == 5 {
                    MCOn.toggle()
                    MCImage.image = UIImage(named: "O")
                    MCImage.isHidden = false
                    MCButton.isEnabled = false
                } else if randomPlay == 6 {
                    MROn.toggle()
                    MRImage.image = UIImage(named: "O")
                    MRImage.isHidden = false
                    MRButton.isEnabled = false
                } else if randomPlay == 7 {
                    BLOn.toggle()
                    BLImage.image = UIImage(named: "O")
                    BLImage.isHidden = false
                    BLButton.isEnabled = false
                } else if randomPlay == 8 {
                    BCOn.toggle()
                    BCImage.image = UIImage(named: "O")
                    BCImage.isHidden = false
                    BCButton.isEnabled = false
                } else if randomPlay == 9 {
                    BROn.toggle()
                    BRImage.image = UIImage(named: "O")
                    BRImage.isHidden = false
                    BRButton.isEnabled = false
                }
                print("current plays left: \(availablePlays)")
                checkForWin()
                if gameIsRunning {
                    toggleAndUpdatePlayerTurns()
                    print("switched player in button press")
                }
                
            }
        }
        
    }
    
    
    // ADD CODE TO DEAL WITH ROBOT
    func randomRobotTurn() {
        if gameIsRunning {
            print("Robot is guessing...")
            // Starts code after 3 seconds to make the game seem realistic
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                print("Robot done guessing!")
                
                //pulls a random play fromthe list of available plays
                let randomPlay = availablePlays.randomElement()!
                print(" Square \(randomPlay) was chosen")
                // gets the first index where that play shows up in the list
                if let firstIndex = availablePlays.firstIndex(of: randomPlay) {
                    // Remove element at that index
                    availablePlays.remove(at: firstIndex)
                }
                
                if randomPlay == 1 {
                    TLOn.toggle()
                    TLImage.image = UIImage(named: "O")
                    TLImage.isHidden = false
                    TLButton.isEnabled = false
                } else if randomPlay == 2 {
                    TCOn.toggle()
                    TCImage.image = UIImage(named: "O")
                    TCImage.isHidden = false
                    TCButton.isEnabled = false
                } else if randomPlay == 3 {
                    TROn.toggle()
                    TRImage.image = UIImage(named: "O")
                    TRImage.isHidden = false
                    TRButton.isEnabled = false
                } else if randomPlay == 4 {
                    MLOn.toggle()
                    MLImage.image = UIImage(named: "O")
                    MLImage.isHidden = false
                    MLButton.isEnabled = false
                } else if randomPlay == 5 {
                    MCOn.toggle()
                    MCImage.image = UIImage(named: "O")
                    MCImage.isHidden = false
                    MCButton.isEnabled = false
                } else if randomPlay == 6 {
                    MROn.toggle()
                    MRImage.image = UIImage(named: "O")
                    MRImage.isHidden = false
                    MRButton.isEnabled = false
                } else if randomPlay == 7 {
                    BLOn.toggle()
                    BLImage.image = UIImage(named: "O")
                    BLImage.isHidden = false
                    BLButton.isEnabled = false
                } else if randomPlay == 8 {
                    BCOn.toggle()
                    BCImage.image = UIImage(named: "O")
                    BCImage.isHidden = false
                    BCButton.isEnabled = false
                } else if randomPlay == 9 {
                    BROn.toggle()
                    BRImage.image = UIImage(named: "O")
                    BRImage.isHidden = false
                    BRButton.isEnabled = false
                }
                checkForWin()
                if gameIsRunning {
                    toggleAndUpdatePlayerTurns()
                    print("switched player in button press")
                }
            }
        }
        
    }
    
    func removeValueFromAvailablePlaysArray(tag: Int) {
        let firstIndex = availablePlays.firstIndex(of: tag)
        print("first index: \(firstIndex!)")
        availablePlays.remove(at: firstIndex!)
        print("Current plays left: \(availablePlays)")
    }
    
    // REQUIREDS TO UPDTAE THIS!!
    // Button Pressed ACTION
    @IBAction func buttonPressed(_ sender: UIButton) {
        if currentPlayer == PlayerTurns.playerX {
            print("Player X pressed a button!")
            switch sender.tag {
            case 1:
                
                TLOn.toggle()
                TLImage.image = UIImage(named: "X")
                TLImage.isHidden = false
                TLButton.isEnabled = false
                removeValueFromAvailablePlaysArray(tag: 1)
                
            case 2:
                TCOn.toggle()
                TCImage.image = UIImage(named: "X")
                TCImage.isHidden = false
                TCButton.isEnabled = false
                removeValueFromAvailablePlaysArray(tag: 2)
                
            case 3:
                TROn.toggle()
                TRImage.image = UIImage(named: "X")
                TRImage.isHidden = false
                TRButton.isEnabled = false
                removeValueFromAvailablePlaysArray(tag: 3)
            case 4:
                MLOn.toggle()
                MLImage.image = UIImage(named: "X")
                MLImage.isHidden = false
                MLButton.isEnabled = false
                removeValueFromAvailablePlaysArray(tag: 4)
            case 5:
                MCOn.toggle()
                MCImage.image = UIImage(named: "X")
                MCImage.isHidden = false
                MCButton.isEnabled = false
                removeValueFromAvailablePlaysArray(tag: 5)
            case 6:
                MROn.toggle()
                MRImage.image = UIImage(named: "X")
                MRImage.isHidden = false
                MRButton.isEnabled = false
                removeValueFromAvailablePlaysArray(tag: 6)
                
            case 7:
                BLOn.toggle()
                BLImage.image = UIImage(named: "X")
                BLImage.isHidden = false
                BLButton.isEnabled = false
                removeValueFromAvailablePlaysArray(tag: 7)
                
            case 8:
                BCOn.toggle()
                BCImage.image = UIImage(named: "X")
                BCImage.isHidden = false
                BCButton.isEnabled = false
                removeValueFromAvailablePlaysArray(tag: 8)
                
            case 9:
                BROn.toggle()
                BRImage.image = UIImage(named: "X")
                BRImage.isHidden = false
                BRButton.isEnabled = false
                removeValueFromAvailablePlaysArray(tag: 9)
                
            default:
                print("Error, something went wrong...")
            }
            checkForWin()
            if gameIsRunning {
                toggleAndUpdatePlayerTurns()
                print("switched player in button press")
            }
            if hardModeOn == false {
                easierRobotTurn()
            } else if hardModeOn == true {
                hardRobotTurn()
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("single player view did load")
        resetGame()
        UserDefaults.standard.set(true, forKey: "toggleState")
        print("viewDidLoad: Hard MOde On = \(hardModeOn)")
        if hardModeOn == false {
            imageView.image = UIImage(named: "happyPopeye")
        } else {
            imageView.image = UIImage(named: "angryPopeye")
        }
        
    }
    
    func toggleAndUpdatePlayerTurns() {
        if currentPlayer == PlayerTurns.computer {
            currentPlayer = PlayerTurns.playerX
            updatePlayerTurnTrackerLabel()
        } else if currentPlayer == PlayerTurns.playerX {
            currentPlayer = PlayerTurns.computer
            updatePlayerTurnTrackerLabel()
        }
    }
    
    func updatePlayerTurnTrackerLabel() {
        if currentPlayer == PlayerTurns.playerX {
            playerTurnTracker.text = "Your Turn!"
        } else if currentPlayer == PlayerTurns.computer {
            playerTurnTracker.text = "Computer Turn!"
        }
    }
    
    var buttonsDisabled: Bool = false
    
    
    func disableAllButtons() {
        TLButton.isEnabled = false
        TCButton.isEnabled = false
        TRButton.isEnabled = false
        MLButton.isEnabled = false
        MCButton.isEnabled = false
        MRButton.isEnabled = false
        BLButton.isEnabled = false
        BCButton.isEnabled = false
        BRButton.isEnabled = false
        buttonsDisabled = true
        
    }
    
    func enableAllButtons() {
        TLButton.isEnabled = true
        TCButton.isEnabled = true
        TRButton.isEnabled = true
        MLButton.isEnabled = true
        MCButton.isEnabled = true
        MRButton.isEnabled = true
        BLButton.isEnabled = true
        BCButton.isEnabled = true
        BRButton.isEnabled = true
        buttonsDisabled = false
    }
    
    func setWinnerText(winner character: String) {
        playerTurnTracker.text = "Player \(character) won!"
        print("Player \(character) won!")
        
    }
    
    func checkForWin() {
        // CHECKING FOR HORIZONTAL WINS
        print("checking for win")
        if TLOn && TCOn && TROn && TLImage.image == UIImage(named: "X") && TCImage.image == UIImage(named: "X") && TRImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true
            gameIsRunning = false
            
        } else if TLOn && TCOn && TROn && TLImage.image == UIImage(named: "O") && TCImage.image == UIImage(named: "O") && TRImage.image == UIImage(named: "O")  {
            disableAllButtons()
            playerTurnTracker.text = "Robot Wins!"
            print("Robot wins!")
            
            newGame.isEnabled = true
            gameIsRunning = false
            
            
        } else if MLOn && MCOn && MROn && MLImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && MRImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true
            gameIsRunning = false
            
        } else if MLOn && MCOn && MROn && MLImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && MRImage.image == UIImage(named: "O")  {
            disableAllButtons()
            playerTurnTracker.text = "Robot Wins!"
            print("Robot wins!")
            
            newGame.isEnabled = true
            gameIsRunning = false
            
        } else if BLOn && BCOn && BROn && BLImage.image == UIImage(named: "X") && BCImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true
            gameIsRunning = false
            
        } else if BLOn && BCOn && BROn && BLImage.image == UIImage(named: "O") && BCImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O") {
            disableAllButtons()
            playerTurnTracker.text = "Robot Wins!"
            print("Robot wins!")
            
            newGame.isEnabled = true
            gameIsRunning = false
            
            // CHECKING FOR VERTICAL WINS
        } else if TLOn && MLOn && BLOn && TLImage.image == UIImage(named: "X") && MLImage.image == UIImage(named: "X") && BLImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true
            gameIsRunning = false
            
        } else if TLOn && MLOn && BLOn && TLImage.image == UIImage(named: "O") && MLImage.image == UIImage(named: "O") && BLImage.image == UIImage(named: "O")  {
            disableAllButtons()
            playerTurnTracker.text = "Robot Wins!"
            print("Robot wins!")
            
            newGame.isEnabled = true
            gameIsRunning = false
            
        } else if TCOn && MCOn && BCOn && TCImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && BCImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true
            gameIsRunning = false
            
        } else if TCOn && MCOn && BCOn && TCImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && BCImage.image == UIImage(named: "O")  {
            disableAllButtons()
            playerTurnTracker.text = "Robot Wins!"
            print("Robot wins!")
            
            newGame.isEnabled = true
            gameIsRunning = false
            
        } else if TROn && MROn && BROn && TRImage.image == UIImage(named: "X") && MRImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true
            gameIsRunning = false
            
        } else if TROn && MROn && BROn && TRImage.image == UIImage(named: "O") && MRImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O")  {
            disableAllButtons()
            playerTurnTracker.text = "Robot Wins!"
            print("Robot wins!")
            
            newGame.isEnabled = true
            gameIsRunning = false
            
            // CHECKING FOR DIAGONAL WINS
        } else if TLOn && MCOn && BROn && TLImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true
            gameIsRunning = false
            
            
        } else if TLOn && MCOn && BROn && TLImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O")  {
            disableAllButtons()
            playerTurnTracker.text = "Robot Wins!"
            print("Robot wins!")
            newGame.isEnabled = true
            gameIsRunning = false
            
            
        } else if TROn && MCOn && BLOn && TRImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && BLImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true
            gameIsRunning = false
            
            
        } else if TROn && MCOn && BLOn && TRImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && BLImage.image == UIImage(named: "O")  {
            playerTurnTracker.text = "Robot Wins!"
            print("Robot wins!")
            disableAllButtons()
            newGame.isEnabled = true
            gameIsRunning = false
            
        } else if TLOn && TCOn && TROn && MLOn && MCOn && MROn && BLOn && BCOn && BROn {
            playerTurnTracker.text = "Draw!"
            print("Draw")
            newGame.isEnabled = true
            gameIsRunning = false
            
        }
        
    }
    
    
    @IBAction func newGameButtonPressed(_ sender: Any) {
        resetGame()
        availablePlays = [1,2,3,4,5,6,7,8,9]
    }
    
    func resetGame() {
        availablePlays = [1,2,3,4,5,6,7,8,9]
        
        currentPlayer = PlayerTurns.playerX
        updatePlayerTurnTrackerLabel()
        enableAllButtons()
        programaticallySetBoxViews()
        resetButtonState()
        newGame.isEnabled = false
        gameIsRunning = true
        print("Current plays: \(availablePlays)")
        resetButtonState()
    }
    


func easierRobotTurn() {
    if gameIsRunning == true {
        print("Robot is thinking easily...")
        // calling [self] in explicitly due to typing code in a closure and referecncing utside objects
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
           
            let randomNumber = Int.random(in: 1...10)
            print("Your random number was \(randomNumber)")
            
            // 90% chance of hard code running
            if randomNumber == 1 || randomNumber == 2 || randomNumber == 3 || randomNumber == 4 || randomNumber == 5 || randomNumber == 6 {
                // HARD CODE..
                // ********************************** HORIZONTAL WINS ********************************** HORIZONTAL WINS **********************************
                // ********************************** HORIZONTAL WINS ********************************** HORIZONTAL WINS **********************************
                // ********************************** HORIZONTAL WINS ********************************** HORIZONTAL WINS **********************************
                if TLOn && TCOn && TLImage.image == UIImage(named: "O") && TCImage.image == UIImage(named: "O") && TROn != true {
                    
                    TROn.toggle()
                    TRImage.image = UIImage(named: "O")
                    TRImage.isHidden = false
                    TRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 3)
                    checkForWinAndUpdateScores()

                } else if TLOn && TROn && TLImage.image == UIImage(named: "O") && TRImage.image == UIImage(named: "O") && TCOn != true{
                    
                    TCOn.toggle()
                    TCImage.image = UIImage(named: "O")
                    TCImage.isHidden = false
                    TCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 2)
                    checkForWinAndUpdateScores()

                } else if TCOn && TROn && TCImage.image == UIImage(named: "O") && TRImage.image == UIImage(named: "O") && TLOn != true{
                    
                    TLOn.toggle()
                    TLImage.image = UIImage(named: "O")
                    TLImage.isHidden = false
                    TLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 1)
                    checkForWinAndUpdateScores()

                } else if MLOn && MCOn && MLImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && MROn != true{
                    
                    MROn.toggle()
                    MRImage.image = UIImage(named: "O")
                    MRImage.isHidden = false
                    MRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 6)
                    checkForWinAndUpdateScores()

                } else if MLOn && MROn && MLImage.image == UIImage(named: "O") && MRImage.image == UIImage(named: "O") && MCOn != true{
                    
                    MCOn.toggle()
                    MCImage.image = UIImage(named: "O")
                    MCImage.isHidden = false
                    MCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 5)
                    checkForWinAndUpdateScores()

                } else if MCOn && MROn && MCImage.image == UIImage(named: "O") && MRImage.image == UIImage(named: "O") && MLOn != true{
                    
                    MLOn.toggle()
                    MLImage.image = UIImage(named: "O")
                    MLImage.isHidden = false
                    MLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 4)
                    checkForWinAndUpdateScores()

                } else if BLOn && BCOn && BLImage.image == UIImage(named: "O") && BCImage.image == UIImage(named: "O") && BROn != true{
                    
                    BROn.toggle()
                    BRImage.image = UIImage(named: "O")
                    BRImage.isHidden = false
                    BRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 9)
                    checkForWinAndUpdateScores()

                } else if BLOn && BROn && BLImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O") && BCOn != true{
                    
                    BCOn.toggle()
                    BCImage.image = UIImage(named: "O")
                    BCImage.isHidden = false
                    BCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 8)
                    checkForWinAndUpdateScores()

                } else if BCOn && BROn && BCImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O") && BLOn != true{
                    
                    BLOn.toggle()
                    BLImage.image = UIImage(named: "O")
                    BLImage.isHidden = false
                    BLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 7)
                    checkForWinAndUpdateScores()

                    // ********************************** VERTICAL WINS ********************************** VERTICAL WINS **********************************
                    // ********************************** VERTICAL WINS ********************************** VERTICAL WINS **********************************
                    // ********************************** VERTICAL WINS ********************************** VERTICAL WINS **********************************
                } else if TLOn && MLOn  && TLImage.image == UIImage(named: "O") && MLImage.image == UIImage(named: "O") && BLOn != true{
                    
                    BLOn.toggle()
                    BLImage.image = UIImage(named: "O")
                    BLImage.isHidden = false
                    BLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 7)
                    checkForWinAndUpdateScores()

                } else if TLOn && BLOn  && TLImage.image == UIImage(named: "O") && BLImage.image == UIImage(named: "O") && MLOn != true{
                    
                    MLOn.toggle()
                    MLImage.image = UIImage(named: "O")
                    MLImage.isHidden = false
                    MLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 4)
                    checkForWinAndUpdateScores()

                } else if MLOn && BLOn  && MLImage.image == UIImage(named: "O") && BLImage.image == UIImage(named: "O") && TLOn != true {
                    
                    TLOn.toggle()
                    TLImage.image = UIImage(named: "O")
                    TLImage.isHidden = false
                    TLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 1)
                    checkForWinAndUpdateScores()

                } else if TCOn && MCOn && TCImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && BCOn != true {
                    
                    BCOn.toggle()
                    BCImage.image = UIImage(named: "O")
                    BCImage.isHidden = false
                    BCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 8)
                    checkForWinAndUpdateScores()

                } else if TCOn && BCOn && TCImage.image == UIImage(named: "O") && BCImage.image == UIImage(named: "O") && MCOn != true{
                    
                    MCOn.toggle()
                    MCImage.image = UIImage(named: "O")
                    MCImage.isHidden = false
                    MCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 5)
                    checkForWinAndUpdateScores()

                } else if MCOn && BCOn && MCImage.image == UIImage(named: "O") && BCImage.image == UIImage(named: "O") && TCOn != true{
                    
                    TCOn.toggle()
                    TCImage.image = UIImage(named: "O")
                    TCImage.isHidden = false
                    TCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 2)
                    checkForWinAndUpdateScores()

                } else if TROn && MROn && TRImage.image == UIImage(named: "O") && MRImage.image == UIImage(named: "O") && BROn != true{
                    
                    BROn.toggle()
                    BRImage.image = UIImage(named: "O")
                    BRImage.isHidden = false
                    BRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 9)
                    checkForWinAndUpdateScores()

                } else if TROn && BROn && TRImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O") && MROn != true{
                    
                    MROn.toggle()
                    MRImage.image = UIImage(named: "O")
                    MRImage.isHidden = false
                    MRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 6)
                    checkForWinAndUpdateScores()

                } else if MROn && BROn && MRImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O") && TROn != true{
                    TROn.toggle()
                    TRImage.image = UIImage(named: "O")
                    TRImage.isHidden = false
                    TRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 3)
                    checkForWinAndUpdateScores()

                    // ********************************** DIAGONAL WINS ********************************** DIAGONAL WINS **********************************
                    // ********************************** DIAGONAL WINS ********************************** DIAGONAL WINS **********************************
                    // ********************************** DIAGONAL WINS ********************************** DIAGONAL WINS **********************************
                } else if TLOn && MCOn && TLImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && BROn != true{
                    
                    BROn.toggle()
                    BRImage.image = UIImage(named: "O")
                    BRImage.isHidden = false
                    BRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 9)
                    checkForWinAndUpdateScores()

                } else if TLOn && BROn && TLImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O") && MCOn != true{
                    
                    MCOn.toggle()
                    MCImage.image = UIImage(named: "O")
                    MCImage.isHidden = false
                    MCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 5)
                    checkForWinAndUpdateScores()

                } else if MCOn && BROn && MCImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O") && TLOn != true{
                    
                    TLOn.toggle()
                    TLImage.image = UIImage(named: "O")
                    TLImage.isHidden = false
                    TLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 1)
                    checkForWinAndUpdateScores()

                } else if TROn && MCOn && TRImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && BLOn != true{
                    
                    BLOn.toggle()
                    BLImage.image = UIImage(named: "O")
                    BLImage.isHidden = false
                    BLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 7)
                    checkForWinAndUpdateScores()

                } else if TROn && BLOn && TRImage.image == UIImage(named: "O") && BLImage.image == UIImage(named: "O") && MCOn != true{
                    
                    MCOn.toggle()
                    MCImage.image = UIImage(named: "O")
                    MCImage.isHidden = false
                    MCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 5)
                    checkForWinAndUpdateScores()

                } else if MCOn && BLOn && MCImage.image == UIImage(named: "O") && BLImage.image == UIImage(named: "O") && TROn != true{
                    
                    TROn.toggle()
                    TRImage.image = UIImage(named: "O")
                    TRImage.isHidden = false
                    TRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 3)
                    checkForWinAndUpdateScores()

                    
                    // BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!!
                    // BLOCKING X  BLOCKING X  BLOCKING X  BLOCKING X  BLOCKING X  BLOCKING X  BLOCKING X  BLOCKING X  BLOCKING X  BLOCKING X
                    // BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!! BLOCKING!!!!
                    
                } else if TLOn && TCOn && TLImage.image == UIImage(named: "X") && TCImage.image == UIImage(named: "X") && TROn != true {
                    
                    TROn.toggle()
                    TRImage.image = UIImage(named: "O")
                    TRImage.isHidden = false
                    TRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 3)
                    checkForWinAndUpdateScores()

                } else if TLOn && TROn && TLImage.image == UIImage(named: "X") && TRImage.image == UIImage(named: "X") && TCOn != true{
                    
                    TCOn.toggle()
                    TCImage.image = UIImage(named: "O")
                    TCImage.isHidden = false
                    TCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 2)
                    checkForWinAndUpdateScores()

                } else if TCOn && TROn && TCImage.image == UIImage(named: "X") && TRImage.image == UIImage(named: "X") && TLOn != true{
                    
                    TLOn.toggle()
                    TLImage.image = UIImage(named: "O")
                    TLImage.isHidden = false
                    TLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 1)
                    checkForWinAndUpdateScores()

                } else if MLOn && MCOn && MLImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && MROn != true{
                    
                    MROn.toggle()
                    MRImage.image = UIImage(named: "O")
                    MRImage.isHidden = false
                    MRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 6)
                    checkForWinAndUpdateScores()

                } else if MLOn && MROn && MLImage.image == UIImage(named: "X") && MRImage.image == UIImage(named: "X") && MCOn != true{
                    
                    MCOn.toggle()
                    MCImage.image = UIImage(named: "O")
                    MCImage.isHidden = false
                    MCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 5)
                    checkForWinAndUpdateScores()

                } else if MCOn && MROn && MCImage.image == UIImage(named: "X") && MRImage.image == UIImage(named: "X") && MLOn != true{
                    
                    MLOn.toggle()
                    MLImage.image = UIImage(named: "O")
                    MLImage.isHidden = false
                    MLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 4)
                    checkForWinAndUpdateScores()

                } else if BLOn && BCOn && BLImage.image == UIImage(named: "X") && BCImage.image == UIImage(named: "X") && BROn != true{
                    
                    BROn.toggle()
                    BRImage.image = UIImage(named: "O")
                    BRImage.isHidden = false
                    BRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 9)
                    checkForWinAndUpdateScores()

                } else if BLOn && BROn && BLImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") && BCOn != true{
                    
                    BCOn.toggle()
                    BCImage.image = UIImage(named: "O")
                    BCImage.isHidden = false
                    BCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 8)
                    checkForWinAndUpdateScores()

                } else if BCOn && BROn && BCImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") && BLOn != true{
                    
                    BLOn.toggle()
                    BLImage.image = UIImage(named: "O")
                    BLImage.isHidden = false
                    BLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 7)
                    checkForWinAndUpdateScores()

                    // ********************************** VERTICAL WINS ********************************** VERTICAL WINS **********************************
                    // ********************************** VERTICAL WINS ********************************** VERTICAL WINS **********************************
                    // ********************************** VERTICAL WINS ********************************** VERTICAL WINS **********************************
                } else if TLOn && MLOn  && TLImage.image == UIImage(named: "X") && MLImage.image == UIImage(named: "X") && BLOn != true{
                    
                    BLOn.toggle()
                    BLImage.image = UIImage(named: "O")
                    BLImage.isHidden = false
                    BLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 7)
                    checkForWinAndUpdateScores()

                } else if TLOn && BLOn  && TLImage.image == UIImage(named: "X") && BLImage.image == UIImage(named: "X") && MLOn != true{
                    
                    MLOn.toggle()
                    MLImage.image = UIImage(named: "O")
                    MLImage.isHidden = false
                    MLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 4)
                    checkForWinAndUpdateScores()

                } else if MLOn && BLOn  && MLImage.image == UIImage(named: "X") && BLImage.image == UIImage(named: "X") && TLOn != true{
                    
                    TLOn.toggle()
                    TLImage.image = UIImage(named: "O")
                    TLImage.isHidden = false
                    TLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 1)
                    checkForWinAndUpdateScores()

                } else if TCOn && MCOn && TCImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && BCOn != true{
                    
                    BCOn.toggle()
                    BCImage.image = UIImage(named: "O")
                    BCImage.isHidden = false
                    BCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 8)
                    checkForWinAndUpdateScores()

                } else if TCOn && BCOn && TCImage.image == UIImage(named: "X") && BCImage.image == UIImage(named: "X") && MCOn != true{
                    
                    MCOn.toggle()
                    MCImage.image = UIImage(named: "O")
                    MCImage.isHidden = false
                    MCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 5)
                    checkForWinAndUpdateScores()

                } else if MCOn && BCOn && MCImage.image == UIImage(named: "X") && BCImage.image == UIImage(named: "X") && TCOn != true{
                    
                    TCOn.toggle()
                    TCImage.image = UIImage(named: "O")
                    TCImage.isHidden = false
                    TCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 2)
                    checkForWinAndUpdateScores()

                } else if TROn && MROn && TRImage.image == UIImage(named: "X") && MRImage.image == UIImage(named: "X") && BROn != true{
                    
                    BROn.toggle()
                    BRImage.image = UIImage(named: "O")
                    BRImage.isHidden = false
                    BRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 9)
                    checkForWinAndUpdateScores()

                } else if TROn && BROn && TRImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") && MROn != true{
                    
                    MROn.toggle()
                    MRImage.image = UIImage(named: "O")
                    MRImage.isHidden = false
                    MRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 6)
                    checkForWinAndUpdateScores()

                } else if MROn && BROn && MRImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") && TROn != true{
                    TROn.toggle()
                    TRImage.image = UIImage(named: "O")
                    TRImage.isHidden = false
                    TRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 3)
                    checkForWinAndUpdateScores()

                    // ********************************** DIAGONAL WINS ********************************** DIAGONAL WINS **********************************
                    // ********************************** DIAGONAL WINS ********************************** DIAGONAL WINS **********************************
                    // ********************************** DIAGONAL WINS ********************************** DIAGONAL WINS **********************************
                } else if TLOn && MCOn && TLImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && BROn != true{
                    
                    BROn.toggle()
                    BRImage.image = UIImage(named: "O")
                    BRImage.isHidden = false
                    BRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 9)
                    checkForWinAndUpdateScores()

                } else if TLOn && BROn && TLImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") && MCOn != true{
                    
                    MCOn.toggle()
                    MCImage.image = UIImage(named: "O")
                    MCImage.isHidden = false
                    MCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 5)
                    checkForWinAndUpdateScores()

                } else if MCOn && BROn && MCImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") && TLOn != true{
                    
                    TLOn.toggle()
                    TLImage.image = UIImage(named: "O")
                    TLImage.isHidden = false
                    TLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 1)
                    checkForWinAndUpdateScores()

                } else if TROn && MCOn && TRImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && BLOn != true {
                    
                    BLOn.toggle()
                    BLImage.image = UIImage(named: "O")
                    BLImage.isHidden = false
                    BLButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 7)
                    checkForWinAndUpdateScores()

                } else if TROn && BLOn && TRImage.image == UIImage(named: "X") && BLImage.image == UIImage(named: "X") && MCOn != true{
                    
                    MCOn.toggle()
                    MCImage.image = UIImage(named: "O")
                    MCImage.isHidden = false
                    MCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 5)
                    checkForWinAndUpdateScores()

                } else if MCOn && BLOn && MCImage.image == UIImage(named: "X") && BLImage.image == UIImage(named: "X") && TROn != true {
                    
                    TROn.toggle()
                    TRImage.image = UIImage(named: "O")
                    TRImage.isHidden = false
                    TRButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 3)
                    checkForWinAndUpdateScores()
                } else if MCOn != true {
                    MCOn.toggle()
                    MCImage.image = UIImage(named: "O")
                    MCImage.isHidden = false
                    MCButton.isEnabled = false
                    removeValueFromAvailablePlaysArray(tag: 5)
                    checkForWinAndUpdateScores()
                } else  {
                    // random play if can't do smart moves
                    print("Normal turn playing because no smart moves were found")
                    hardRandomRobotTurn()
                }
                
                
            } else {
                // 80% chance of making mistake selected
                print("80% chance of making mistake selected")
                hardRandomRobotTurn()
            }
        }
        
        
    }
}

}

