//
//  Extensions.swift
//  tictactoe
//
//  Created by Amin  Bagheri  on 2022-05-28.
//

import Foundation
import UIKit


// we are using the presentation controller we made to actually show the view controller (what we will present)
extension SinglePlayerViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension SinglePlayerViewController: DifficultySelectionDelegate {
    
    // this function get's called whenever the switch is ressed in the overlay view controller due to us setting thw augnle player view controller as the intern or "self"
    func didTapChoice(easySettings: Bool, image: UIImage) {
        
        resetGame()
        availablePlays = [1,2,3,4,5,6,7,8,9]
        if easySettings == true {
            UserDefaults.standard.set(true, forKey: "hardMode")
            self.hardModeOn = UserDefaults.standard.bool(forKey: "hardMode")
            imageView.image = image
        } else {
            hardModeOn = false
            imageView.image = UIImage(named: "happyPopeye")
        }
        
        print("Hard Mode On: \(hardModeOn)")
    }
    
    
}


