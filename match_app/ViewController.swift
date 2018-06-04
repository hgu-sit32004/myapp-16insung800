//
//  ViewController.swift
//  match_app
//
//  Created by student33 on 2018. 5. 14..
//  Copyright © 2018년 student33. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call the getCards method of the card model
        cardArray = model.getCard()
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -UICollectionviw Protocol Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Get a CardCollectionviewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardColeCollectionViewCell
        
        // Get the card that the collection view is trying to display
        let card = cardArray[indexPath.row]
        
        // Set that card for the cell
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Get the cell that the user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardColeCollectionViewCell
        
        // Get the card that the user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            
            // Flip the card
            cell.flip()
            
            // Set the status of the card
            card.isFlipped = true
            
            // Determine if it's the first card or second card that's flupped over
            
            if firstFlippedCardIndex == nil{
                
                //this is the first card being flipped
                firstFlippedCardIndex = indexPath
            }
            else{
                
                // this is the second card being flipped
                
                // perform the matching logic
                checkForMatches(indexPath)
            }
        }
            
            
        else {
            // Flip the card back
            cell.flipBack()
            
            // Set the status of the card
            card.isFlipped = false
        }
        
        
        
    }//End the didSelectItemAt method
    
    // MARK: - Game Logic Methods
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath){
        
        //Get the cells for the two cards that were revealed
        let cardOneCell = CollectionView.cellForItem(at: firstFlippedCardIndex!) as? CardColeCollectionViewCell
        
        let cardTowCell = CollectionView.cellForItem(at: secondFlippedCardIndex) as? CardColeCollectionViewCell
        
        // Get the cards for the two cards that were revealed
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        // Compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            
            // It's a match
            
            // Set the statuses of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // Remove the cards from the grid
            cardOneCell?.remove()
            cardTowCell?.remove()
        }
        else{
            // It's not a match
            
            // set the statuses of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Flip both cards back
            cardOneCell?.flipBack()
            cardTowCell?.flipBack()
        }
        
        // Tell the collectionview to reload the cell of the first card if it is nil
        if cardOneCell == nil{
            CollectionView.reloadItems(at: [firstFlippedCardIndex!])
        }

        
        // Reset the property that tracks the first card flipped
        firstFlippedCardIndex = nil
    }
    

} //End view Controller class



