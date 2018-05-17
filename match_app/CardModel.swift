//
//  CardModel.swift
//  match_app
//
//  Created by student33 on 2018. 5. 17..
//  Copyright © 2018년 student33. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCard() -> [Card] {
        
        // declare an array to store the generated cards
        var generatedCardArray = [Card]()
        
        // Randomly generate pairs of cards
        for _ in 1...8 {
            
            // Get a random number
            let randomNumber = arc4random_uniform(13) + 1
            
            // Log the number
            print(randomNumber)
            
            // Create the first card object
            var cardOne = Card()
            cardOne.imageName = "card\(randomNumber)"
            
            
            generatedCardArray.append(cardOne)
            
            // Create the second card object
            let cardTwo = Card()
            cardTwo.imageName = "card\(randomNumber)"
            
            cardOne.imageName = "card\(randomNumber)"
            
            generatedCardArray.append(cardTwo)
            
            // OPTIONAL: Make it so we only have uniqe pairs of cards
        }
        // TODO: Randomize the array
        
        // Return the arry
        return generatedCardArray
        
        
    }
    
    
}


