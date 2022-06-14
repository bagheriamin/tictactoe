//
//  LocalMultiplayerViewController.swift
//  tictactoe
//
//  Created by Amin  Bagheri  on 2022-05-31.
//

import UIKit
import MultipeerConnectivity

class LocalMultiplayerViewController: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate {
    // MCBrowserViewController is used when looking for sessions, showing users who is nearby and letting them join.
    
    //choose side button
    @IBOutlet var chooseSideButton: UIButton!
    var sideChosen:Bool = false
    var side: String = "X"
    
    @IBAction func chooseSideButtonPressed(_ sender: UIButton) {
        let ac = UIAlertController(title: "Choose your side:", message: nil, preferredStyle: .alert)
        let chooseX = UIAlertAction(title: "Play as X", style: .default) { [self] (UIAlertAction) in
            side = "X"
            chooseSideButton.setTitle("You are player X!", for: .normal)
            chooseSideButton.isUserInteractionEnabled = false
            enableAllButtons()
            if mcSession.connectedPeers.count > 0 {
                if let safeChosenPlayerData = side.data(using: .utf8) {
                    do {
                        try mcSession.send(safeChosenPlayerData, toPeers: mcSession.connectedPeers, with: .reliable)
                    } catch let error as NSError {
                        print("\(error.localizedDescription)")
                    }
                }
            }
        }
        let chooseO = UIAlertAction(title: "Play as O", style: .default) { [self] (UIAlertAction) in
            side = "O"
            chooseSideButton.setTitle("You are player O!", for: .normal)
            chooseSideButton.isUserInteractionEnabled = false
            enableAllButtons()
            if mcSession.connectedPeers.count > 0 {
                if let safeChosenPlayerData = side.data(using: .utf8) {
                    do {
                        try mcSession.send(safeChosenPlayerData, toPeers: mcSession.connectedPeers, with: .reliable)
                    } catch let error as NSError {
                        print("\(error.localizedDescription)")
                    }
                }
            }
        }
        
        let cancelChooseCharacter = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(chooseX)
        ac.addAction(chooseO)
        ac.addAction(cancelChooseCharacter)
        present(ac, animated: true)
    }
    
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
    
    // works in same was as the previous button state variables above, but used for data sending to the network
    var TLString = "false"
    var TCString = "false"
    var TRString = "false"
    var MLString = "false"
    var MCString = "false"
    var MRString = "false"
    var BLString = "false"
    var BCString = "false"
    var BRString = "false"
    
    
    
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
    
    
    // Multipeer Connectivity Required Variables
    
    var peerID: MCPeerID! /// uniquely identifies a user within a session
    var mcSession: MCSession! /// the manager class that handles all multipeer connectivity
    var mcAdvertiserAssistant: MCAdvertiserAssistant! /// used for creating a session, telling others that we exist and handling invitations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Mulipeer Connectivity Code
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
        
        // Game functionality code
        newGame.isEnabled = false
        currentPlayer = PlayerTurns.playerX
        updatePlayerTurnTrackerLabel()
        disableAllButtons()
        programaticallySetBoxViews()
    }
    
    // required MCSESSIONDELEGATE protocol stubs
    
    // This first require method allows us to see if the connection status has changed. It has several properties that you can check.
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            print("Not Connected: \(peerID)")
        case .connecting:
            print("Connecting: \(peerID)")
        case .connected:
            print("Connected: \(peerID)")
        default:
            print("Unknown status of \(peerID)")
        }
    }
    
    func resetGame() {
        currentPlayer = PlayerTurns.playerX
        updatePlayerTurnTrackerLabel()
        enableAllButtons()
        programaticallySetBoxViews()
        resetButtonState()
        newGame.isEnabled = false
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
        DispatchQueue.main.async { [weak self] in
            if let playNewGame = String(data: data, encoding: .utf8){
                if playNewGame == "true" {
                    self!.resetGame()
            }
            }
            
            if let buttonState = String(data: data, encoding: .utf8) {
                print("Button State: \(buttonState)")
                if buttonState == "trueTLX" {
                    
                    self!.TLOn.toggle()
                    self!.TLImage.image = UIImage(named: "X")
                    self!.TLImage.isHidden = false
                    self!.TLButton.isEnabled = false
                    self!.TLString = "trueTLX"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueTCX" {
                    
                    self!.TCOn.toggle()
                    self!.TCImage.image = UIImage(named: "X")
                    self!.TCImage.isHidden = false
                    self!.TCButton.isEnabled = false
                    self!.TCString = "trueTCX"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueTRX" {
                    
                    self!.TROn.toggle()
                    self!.TRImage.image = UIImage(named: "X")
                    self!.TRImage.isHidden = false
                    self!.TRButton.isEnabled = false
                    self!.TRString = "trueTRX"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueMLX" {
                    
                    self!.MLOn.toggle()
                    self!.MLImage.image = UIImage(named: "X")
                    self!.MLImage.isHidden = false
                    self!.MLButton.isEnabled = false
                    self!.MLString = "trueMLX"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueMCX" {
                    
                    self!.MCOn.toggle()
                    self!.MCImage.image = UIImage(named: "X")
                    self!.MCImage.isHidden = false
                    self!.MCButton.isEnabled = false
                    self!.MCString = "trueMCX"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueMRX" {
                    
                    self!.MROn.toggle()
                    self!.MRImage.image = UIImage(named: "X")
                    self!.MRImage.isHidden = false
                    self!.MRButton.isEnabled = false
                    self!.MRString = "trueMRX"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueBLX" {
                    
                    self!.BLOn.toggle()
                    self!.BLImage.image = UIImage(named: "X")
                    self!.BLImage.isHidden = false
                    self!.BLButton.isEnabled = false
                    self!.BLString = "trueBLX"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueBCX" {
                    
                    self!.BCOn.toggle()
                    self!.BCImage.image = UIImage(named: "X")
                    self!.BCImage.isHidden = false
                    self!.BCButton.isEnabled = false
                    self!.BCString = "trueBCX"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueBRX" {
                    
                    self!.BROn.toggle()
                    self!.BRImage.image = UIImage(named: "X")
                    self!.BRImage.isHidden = false
                    self!.BRButton.isEnabled = false
                    self!.BRString = "trueBRX"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueTLO" {
                    
                    self!.TLOn.toggle()
                    self!.TLImage.image = UIImage(named: "O")
                    self!.TLImage.isHidden = false
                    self!.TLButton.isEnabled = false
                    self!.TLString = "trueTLO"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueTCO" {
                    
                    self!.TCOn.toggle()
                    self!.TCImage.image = UIImage(named: "O")
                    self!.TCImage.isHidden = false
                    self!.TCButton.isEnabled = false
                    self!.TCString = "trueTCO"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueTRO" {
                    
                    self!.TROn.toggle()
                    self!.TRImage.image = UIImage(named: "O")
                    self!.TRImage.isHidden = false
                    self!.TRButton.isEnabled = false
                    self!.TRString = "trueTRO"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueMLO" {
                    
                    self!.MLOn.toggle()
                    self!.MLImage.image = UIImage(named: "O")
                    self!.MLImage.isHidden = false
                    self!.MLButton.isEnabled = false
                    self!.MLString = "trueMLO"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueMCO" {
                    
                    self!.MCOn.toggle()
                    self!.MCImage.image = UIImage(named: "O")
                    self!.MCImage.isHidden = false
                    self!.MCButton.isEnabled = false
                    self!.MCString = "trueMCO"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueMRO" {
                    
                    self!.MROn.toggle()
                    self!.MRImage.image = UIImage(named: "O")
                    self!.MRImage.isHidden = false
                    self!.MRButton.isEnabled = false
                    self!.MRString = "trueMRO"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueBLO" {
                    
                    self!.BLOn.toggle()
                    self!.BLImage.image = UIImage(named: "O")
                    self!.BLImage.isHidden = false
                    self!.BLButton.isEnabled = false
                    self!.BLString = "trueBLO"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueBCO" {
                    
                    self!.BCOn.toggle()
                    self!.BCImage.image = UIImage(named: "O")
                    self!.BCImage.isHidden = false
                    self!.BCButton.isEnabled = false
                    self!.BCString = "trueBCO"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                } else if buttonState == "trueBRO" {
                    
                    self!.BROn.toggle()
                    self!.BRImage.image = UIImage(named: "O")
                    self!.BRImage.isHidden = false
                    self!.BRButton.isEnabled = false
                    self!.BRString = "trueBRO"
                    
                    if self!.buttonsDisabled == false {
                        self!.toggleAndUpdatePlayerTurns()
                        print("switched player")
                    }
                    self!.checkForWin()
                }
            }
            if let chosenPlayer = String(data: data, encoding: .utf8) {
                if chosenPlayer == "X" {
                    print("didRecieveData: Other Players side chosen was X")
                    self!.chooseSideButton.setTitle("You are player O!", for: .normal)
                    self!.chooseSideButton.isUserInteractionEnabled = false
                    self!.enableAllButtons()
                }
                
                
            }
            if let chosenPlayer = String(data: data, encoding: .utf8) {
                if chosenPlayer == "O" {
                    print("didRecieveData: Other players side chosen was O")
                    self!.chooseSideButton.setTitle("You are player X!", for: .normal)
                    self!.chooseSideButton.isUserInteractionEnabled = false
                    self!.enableAllButtons()
                }
                
            }
        }
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) { }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) { }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) { }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true) /// dismisses the browser view controller when we're done connecting
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true) /// dismisses the browser view controller if cancel was hit.
    }
    
    // CONNECT BUTTON PRESS
    @IBAction func connectButtonPressed(_ sender: UIBarButtonItem) {
        
        // FIXME: Change titles later to be more child friendly
        // creating an alertController
        let alertController = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .alert)
        
        // adding diffeerent actions to the controller
        alertController.addAction(UIAlertAction(title: "Host a session", style: .default) { [self] (UIAlertAction) in
            // creating a MCAdvertiserAssistant to help advertise the sessions
            mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "todo", discoveryInfo: nil, session: mcSession)
            // start advertsing:
            mcAdvertiserAssistant.start()
            
        })
        
        alertController.addAction(UIAlertAction(title: "Join a session", style: .default) { [self] (UIAlertAction) in
            let mcBrowser = MCBrowserViewController(serviceType: "todo", session: mcSession)
            mcBrowser.delegate = self
            present(mcBrowser, animated: true, completion: nil)
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertController, animated: true)
    }
    
    // Button Pressed ACTION
    @IBAction func buttonPressed(_ sender: UIButton) {
        if currentPlayer == PlayerTurns.playerX && chooseSideButton.titleLabel!.text! == "You are player X!" {
            print("\(chooseSideButton.titleLabel!.text!)")
            print("Player X pressed a button!")
            switch sender.tag {
            case 1:
                
                TLOn.toggle()
                TLImage.image = UIImage(named: "X")
                TLImage.isHidden = false
                TLButton.isEnabled = false
                TLString = "trueTLX"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeData = TLString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
                
            case 2:
                TCOn.toggle()
                TCImage.image = UIImage(named: "X")
                TCImage.isHidden = false
                TCButton.isEnabled = false
                TCString = "trueTCX"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeData = TCString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            case 3:
                TROn.toggle()
                TRImage.image = UIImage(named: "X")
                TRImage.isHidden = false
                TRButton.isEnabled = false
                TRString = "trueTRX"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeData = TRString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            case 4:
                MLOn.toggle()
                MLImage.image = UIImage(named: "X")
                MLImage.isHidden = false
                MLButton.isEnabled = false
                MLString = "trueMLX"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeData = MLString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            case 5:
                MCOn.toggle()
                MCImage.image = UIImage(named: "X")
                MCImage.isHidden = false
                MCButton.isEnabled = false
                MCString = "trueMCX"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeData = MCString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
                
            case 6:
                MROn.toggle()
                MRImage.image = UIImage(named: "X")
                MRImage.isHidden = false
                MRButton.isEnabled = false
                MRString = "trueMRX"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeData = MRString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            case 7:
                BLOn.toggle()
                BLImage.image = UIImage(named: "X")
                BLImage.isHidden = false
                BLButton.isEnabled = false
                BLString = "trueBLX"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeData = BLString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            case 8:
                BCOn.toggle()
                BCImage.image = UIImage(named: "X")
                BCImage.isHidden = false
                BCButton.isEnabled = false
                BCString = "trueBCX"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeData = BCString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            case 9:
                BROn.toggle()
                BRImage.image = UIImage(named: "X")
                BRImage.isHidden = false
                BRButton.isEnabled = false
                BRString = "trueBRX"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeData = BRString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            default:
                print("Error, something went wrong...")
            }
            if buttonsDisabled == false {
                toggleAndUpdatePlayerTurns()
                print("switched player")
            }
            checkForWin()
            
        } else if currentPlayer == PlayerTurns.playerO && chooseSideButton.titleLabel!.text == "You are player O!"{
            print("Player O pressed a button!")
            switch sender.tag {
            case 1:
                TLOn.toggle()
                TLImage.image = UIImage(named: "O")
                TLImage.isHidden = false
                TLButton.isEnabled = false
                TLString = "trueTLO"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeOData = TLString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeOData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            case 2:
                TCOn.toggle()
                TCImage.image = UIImage(named: "O")
                TCImage.isHidden = false
                TCButton.isEnabled = false
                TCString = "trueTCO"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeOData = TCString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeOData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            case 3:
                TROn.toggle()
                TRImage.image = UIImage(named: "O")
                TRImage.isHidden = false
                TRButton.isEnabled = false
                TRString = "trueTRO"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeOData = TRString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeOData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            case 4:
                MLOn.toggle()
                MLImage.image = UIImage(named: "O")
                MLImage.isHidden = false
                MLButton.isEnabled = false
                MLString = "trueMLO"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeOData = MLString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeOData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            case 5:
                MCOn.toggle()
                MCImage.image = UIImage(named: "O")
                MCImage.isHidden = false
                MCButton.isEnabled = false
                MCString = "trueMCO"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeOData = MCString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeOData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            case 6:
                MROn.toggle()
                MRImage.image = UIImage(named: "O")
                MRImage.isHidden = false
                MRButton.isEnabled = false
                MRString = "trueMRO"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeOData = MRString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeOData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            case 7:
                BLOn.toggle()
                BLImage.image = UIImage(named: "O")
                BLImage.isHidden = false
                BLButton.isEnabled = false
                BLString = "trueBLO"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeOData = BLString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeOData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            case 8:
                BCOn.toggle()
                BCImage.image = UIImage(named: "O")
                BCImage.isHidden = false
                BCButton.isEnabled = false
                BCString = "trueBCO"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeOData = BCString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeOData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            case 9:
                BROn.toggle()
                BRImage.image = UIImage(named: "O")
                BRImage.isHidden = false
                BRButton.isEnabled = false
                BRString = "trueBRO"
                
                if mcSession.connectedPeers.count > 0 {
                    if let safeOData = BRString.data(using: .utf8) {
                        do {
                            try mcSession.send(safeOData, toPeers: mcSession.connectedPeers, with: .reliable)
                        } catch let error as NSError {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
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
    
    var playNewGame: String = "false"
    
    @IBAction func newGameButtonPressed(_ sender: Any) {
        resetGame()
        playNewGame = "true"
        if mcSession.connectedPeers.count > 0 {
            if let playNewGameData = playNewGame.data(using: .utf8) {
                do {
                    try mcSession.send(playNewGameData, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch let error as NSError {
                    print("\(error.localizedDescription)")
                }
            }
        }
        
    
    
}
}
