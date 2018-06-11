//
//  ViewController.swift
//  match_app
//
//  Created by student33 on 2018. 5. 14..
//  Copyright © 2018년 student33. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    var timer:Timer?
    var millisecond:Float = 10 * 1000 // 10 seconds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call the getCards method of the card model
        cardArray = model.getCard()
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        // Create timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Timer Methods
    
    @objc func timerElapsed(){
        
        millisecond -= 1
        
        //Convert to seconds
        let seconds = String(format: "%.2f", millisecond/1000)
        
        // Set label
        timeLabel.text = "Time Remaining: \(seconds)"
        
        // When the timer has reached 0...
        if millisecond <= 0 {
            
            // Stop the timer
            timer?.invalidate()
            timeLabel.textColor = UIColor.red
            
            //Check if there are any cards unmatched
            checkGameEnded()
            
        }
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
        
        // Check if there's any time left
        if millisecond <= 0{
            return
        }
        
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
            
            // check if there are any left unmatched
            checkGameEnded()
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
    
    func checkGameEnded(){
        
        //Determine if there are any cards unmatched
        var isWon = true
        
        for card in cardArray{
            
            if card.isMatched == false{
                isWon = false
                break
            }
        }
        // Messaging variable
        var title = ""
        var message = ""
        
        
        
        // If not, then suer has won, stop the timer
        if isWon == true {
            if millisecond > 0{
            timer?.invalidate()
        }
        
        title = "Congratulations!"
        message = "You've won"
            
    }
        
    else{
        // If there are unmatched cards, check if there's nay time left
    
            if millisecond > 0{
                return
            }
            
            title = "Game Over"
            message = "You've lost"
        }
    
        // Show won/lost messaging
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)

    }
    
    
    
    

} //End view Controller class



