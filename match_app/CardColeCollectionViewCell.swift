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
        UIView.transition(from: frontImageview, to: backImageViw, duration: 0.3, options: [. transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        
    }
}
