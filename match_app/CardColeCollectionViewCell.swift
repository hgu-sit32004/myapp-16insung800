//
//  CardColeCollectionViewCell.swift
//  match_app
//
//  Created by student33 on 2018. 5. 17..
//  Copyright © 2018년 student33. All rights reserved.
//

import UIKit

class CardColeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageview: UIImageView!
    
    @IBOutlet weak var backImageViw: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card) {
        
        // Keep track of the card that gets passed in
        self.card = card
        
        if card.isMatched == true{
            
            //if the card has been matched, then make the image views invisible
            backImageViw.alpha = 0
            frontImageview.alpha = 0
            
            return
        }
        else{
            
            //If the card hasn't been matched, then make the image views visible
            backImageViw.alpha = 1
            frontImageview.alpha = 1
        }
        
        frontImageview.image = UIImage(named: card.imageName)
        
        // Determine of the card is in a flipped up state of flipped down state
        if card.isFlipped == true {
            // Make sure the front imageview is on top
            UIView.transition(from: backImageViw, to: frontImageview, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        else{
            // Make sure the backimageview is on top
            UIView.transition(from: frontImageview, to: backImageViw, duration: 0, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        }
    }
    
    func flip() {
        
        UIView.transition(from: backImageViw, to: frontImageview, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }

    func flipBack(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            UIView.transition(from: self.frontImageview, to: self.backImageViw, duration: 0.3, options: [. transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
        
    }
    
    func remove(){
        
        // Removes both imageviews from being visible
        backImageViw.alpha = 0
        
        // Animate it
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImageview.alpha = 0
            
        }, completion: nil)
        
        
        
        
        
        
        
        
    }
}


