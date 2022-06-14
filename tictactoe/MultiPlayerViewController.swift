//
//  ViewController.swift
//  tictactoe
//
//  Created by Amin  Bagheri  on 2022-05-28.
//

import UIKit

class MultiPlayerViewController: UIViewController {
    
    // Choose side button:
    
    
    // New Game Button
    @IBOutlet var newGame: UIButton!
    
    
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
    
    // Player Turn Tracker Label
    @IBOutlet var playerTurnTracker: UILabel!
    
    // currentPlayer variable (set to enum)
    var currentPlayer: PlayerTurns
    
    required init?(coder: NSCoder) {
        self.currentPlayer = PlayerTurns.playerX
        super.init(coder: coder)
    }
    
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
            case 2:
                TCOn.toggle()
                TCImage.image = UIImage(named: "X")
                TCImage.isHidden = false
                TCButton.isEnabled = false
            case 3:
                TROn.toggle()
                TRImage.image = UIImage(named: "X")
                TRImage.isHidden = false
                TRButton.isEnabled = false
            case 4:
                MLOn.toggle()
                MLImage.image = UIImage(named: "X")
                MLImage.isHidden = false
                MLButton.isEnabled = false
            case 5:
                MCOn.toggle()
                MCImage.image = UIImage(named: "X")
                MCImage.isHidden = false
                MCButton.isEnabled = false
            case 6:
                MROn.toggle()
                MRImage.image = UIImage(named: "X")
                MRImage.isHidden = false
                MRButton.isEnabled = false
            case 7:
                BLOn.toggle()
                BLImage.image = UIImage(named: "X")
                BLImage.isHidden = false
                BLButton.isEnabled = false
            case 8:
                BCOn.toggle()
                BCImage.image = UIImage(named: "X")
                BCImage.isHidden = false
                BCButton.isEnabled = false
            case 9:
                BROn.toggle()
                BRImage.image = UIImage(named: "X")
                BRImage.isHidden = false
                BRButton.isEnabled = false
            default:
                print("Error, something went wrong...")
            }
            if buttonsDisabled == false {
                toggleAndUpdatePlayerTurns()
                print("switched player")
            }
            checkForWin()
            
        } else if currentPlayer == PlayerTurns.playerO {
            print("Player O pressed a button!")
            switch sender.tag {
            case 1:
                TLOn.toggle()
                TLImage.image = UIImage(named: "O")
                TLImage.isHidden = false
                TLButton.isEnabled = false
            case 2:
                TCOn.toggle()
                TCImage.image = UIImage(named: "O")
                TCImage.isHidden = false
                TCButton.isEnabled = false
            case 3:
                TROn.toggle()
                TRImage.image = UIImage(named: "O")
                TRImage.isHidden = false
                TRButton.isEnabled = false
            case 4:
                MLOn.toggle()
                MLImage.image = UIImage(named: "O")
                MLImage.isHidden = false
                MLButton.isEnabled = false
            case 5:
                MCOn.toggle()
                MCImage.image = UIImage(named: "O")
                MCImage.isHidden = false
                MCButton.isEnabled = false
            case 6:
                MROn.toggle()
                MRImage.image = UIImage(named: "O")
                MRImage.isHidden = false
                MRButton.isEnabled = false
            case 7:
                BLOn.toggle()
                BLImage.image = UIImage(named: "O")
                BLImage.isHidden = false
                BLButton.isEnabled = false
            case 8:
                BCOn.toggle()
                BCImage.image = UIImage(named: "O")
                BCImage.isHidden = false
                BCButton.isEnabled = false
            case 9:
                BROn.toggle()
                BRImage.image = UIImage(named: "O")
                BRImage.isHidden = false
                BRButton.isEnabled = false
            default:
                print("Error, something went wrong...")
            }
            
            if buttonsDisabled == false {
                toggleAndUpdatePlayerTurns()
                print("switched player")
                
            }
            checkForWin()
            
        }
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGame.isEnabled = false
        currentPlayer = PlayerTurns.playerX
        updatePlayerTurnTrackerLabel()
        enableAllButtons()
        programaticallySetBoxViews()
    }
    
    func toggleAndUpdatePlayerTurns() {
        if currentPlayer == PlayerTurns.playerO {
            currentPlayer = PlayerTurns.playerX
            updatePlayerTurnTrackerLabel()
        } else if currentPlayer == PlayerTurns.playerX {
            currentPlayer = PlayerTurns.playerO
            updatePlayerTurnTrackerLabel()
        }
    }
    
    func updatePlayerTurnTrackerLabel() {
        if currentPlayer == PlayerTurns.playerX {
            playerTurnTracker.text = "X Player!"
        } else if currentPlayer == PlayerTurns.playerO {
            playerTurnTracker.text = "O Player!"
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
        if TLOn && TCOn && TROn && TLImage.image == UIImage(named: "X") && TCImage.image == UIImage(named: "X") && TRImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true

        } else if TLOn && TCOn && TROn && TLImage.image == UIImage(named: "O") && TCImage.image == UIImage(named: "O") && TRImage.image == UIImage(named: "O")  {
            disableAllButtons()
            setWinnerText(winner: "O")
            newGame.isEnabled = true

            
        } else if MLOn && MCOn && MROn && MLImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && MRImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true

        } else if MLOn && MCOn && MROn && MLImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && MRImage.image == UIImage(named: "O")  {
            disableAllButtons()
            setWinnerText(winner: "O")
            newGame.isEnabled = true

        } else if BLOn && BCOn && BROn && BLImage.image == UIImage(named: "X") && BCImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true

        } else if BLOn && BCOn && BROn && BLImage.image == UIImage(named: "O") && BCImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O") {
            disableAllButtons()
            setWinnerText(winner: "O")
            newGame.isEnabled = true

            // CHECKING FOR VERTICAL WINS
        } else if TLOn && MLOn && BLOn && TLImage.image == UIImage(named: "X") && MLImage.image == UIImage(named: "X") && BLImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true

        } else if TLOn && MLOn && BLOn && TLImage.image == UIImage(named: "O") && MLImage.image == UIImage(named: "O") && BLImage.image == UIImage(named: "O")  {
            disableAllButtons()
            setWinnerText(winner: "O")
            newGame.isEnabled = true

        } else if TCOn && MCOn && BCOn && TCImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && BCImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true

        } else if TCOn && MCOn && BCOn && TCImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && BCImage.image == UIImage(named: "O")  {
            disableAllButtons()
            setWinnerText(winner: "O")
            newGame.isEnabled = true

        } else if TROn && MROn && BROn && TRImage.image == UIImage(named: "X") && MRImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true

        } else if TROn && MROn && BROn && TRImage.image == UIImage(named: "O") && MRImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O")  {
            disableAllButtons()
            setWinnerText(winner: "O")
            newGame.isEnabled = true

            // CHECKING FOR DIAGONAL WINS
        } else if TLOn && MCOn && BROn && TLImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && BRImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true

            
        } else if TLOn && MCOn && BROn && TLImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && BRImage.image == UIImage(named: "O")  {
            disableAllButtons()
            setWinnerText(winner: "O")
            newGame.isEnabled = true

            
        } else if TROn && MCOn && BLOn && TRImage.image == UIImage(named: "X") && MCImage.image == UIImage(named: "X") && BLImage.image == UIImage(named: "X") {
            setWinnerText(winner: "X")
            disableAllButtons()
            newGame.isEnabled = true

            
        } else if TROn && MCOn && BLOn && TRImage.image == UIImage(named: "O") && MCImage.image == UIImage(named: "O") && BLImage.image == UIImage(named: "O")  {
            setWinnerText(winner: "O")
            disableAllButtons()
            newGame.isEnabled = true

        } else if TLOn && TCOn && TROn && MLOn && MCOn && MROn && BLOn && BCOn && BROn {
            playerTurnTracker.text = "Draw!"
            print("Draw")
            newGame.isEnabled = true
        }
        
    }
    
    
    @IBAction func newGameButtonPressed(_ sender: Any) {
        resetGame()
    }
    
    func resetGame() {
        currentPlayer = PlayerTurns.playerX
        updatePlayerTurnTrackerLabel()
        enableAllButtons()
        programaticallySetBoxViews()
        resetButtonState()
        newGame.isEnabled = false

    }
    
}



