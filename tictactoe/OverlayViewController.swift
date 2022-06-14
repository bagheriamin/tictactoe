//
//  OverlayViewController.swift
//  tictactoe
//
//  Created by Amin  Bagheri  on 2022-05-29.
//

import UIKit

// CREATE PROTOCOL IN BOSS SCREEN (protocol is like a command list for intern)
// creates a protocol that allows us to send in angry popeye image AND allows us to send the diffuclty setting (on and off state) of the switch to anny clas that adopts this protocol
protocol DifficultySelectionDelegate {
    func didTapChoice(easySettings: Bool, image: UIImage)
}

// creates an instance of the protocol
var selectionDelegate: DifficultySelectionDelegate!

// this class basically works with deraling with the gesture recognizer of the view
class OverlayViewController: UIViewController {
    
    
    // OUtlet for switch
    @IBOutlet var difficultySwitch: UISwitch!
    
    
    //ACTION FOR DIFFICULTY BUTTON:
    @IBAction func difficultySettingsChanged(_ sender: UISwitch) {
        
        
        //using the delegate function
         selectionDelegate.didTapChoice(easySettings: UserDefaults.standard.bool(forKey: "toggleState"), image: UIImage(named: "angryPopeye")!)
         
        
        // setting the value for the "toggleState" key in UserDefaults. if sender is on, the bool value is true, and if the sender (the switch) is off, the value is false.
        UserDefaults.standard.set(sender.isOn, forKey: "toggleState")
        
    }
    
    
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    override func viewWillAppear(_ animated: Bool) {
        print("overlay View will appear")
        // the setOn method can be true or false. to find out which, use  userdefaults .bool, and find out what the boolean value was. set it as the value of the switch
        self.difficultySwitch.setOn(UserDefaults.standard.bool(forKey: "toggleState"), animated: true)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("overlay View Did Load")
        // creates a gesture that follows the panGestureRecognizerAction function on the overlyviewcontroler(self)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        // adding the gesture so that user can slide up and down the view
        view.addGestureRecognizer(panGesture)
    }
    
    // calls to nitify the view contorller that the view controller has finished laying out its subviews
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            // origin is the point origin of the frame
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        // allows for interpreting the translation of the pan gesture
        let translation = sender.translation(in: view)
        
        // prevents the user from dragging the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we dont want users to be able to drag the frame left and right! Only want straight down, or back up to starting origin
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        // if the state of the continuous gesture has ended
        if sender.state == .ended {
            // gets the velocity of the gesture
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
}
