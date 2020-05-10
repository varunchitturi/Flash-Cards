//
//  viewDeckFlashCards.swift
//  Flash Cards
//
//  Created by Varun Chitturi on 5/9/20.
//  Copyright © 2020 School Works. All rights reserved.
//

import UIKit

class viewDeckFlashCards: UIViewController {
    var currentdeck = Deck()
    var currentSide = 1
    
    // if current side is 1 show the front
    @IBOutlet weak var flipCardButton: UIButton!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var cardText: UILabel!

    // if current side is 2 show the back
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
       
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        var cardArray = currentdeck.cards?.allObjects as! [Card]
         cardArray.sort {
            if $0.front != $1.front {
                return $0.front! < $1.front!
            }
            else {
                return $0.back! < $1.back!
            }
        }
        let card = cardArray[0]
        
        if(card.front != nil){
            cardText.text = card.front}
        else{
            cardText.text = ""
        }
        
        pageController.numberOfPages = cardArray.count
    }
    @IBAction func flip(_ sender: Any) {
       var currentArray = currentdeck.cards?.allObjects as! [Card]
         currentArray.sort {
            if $0.front != $1.front { // first, compare by last names
                return $0.front! < $1.front!
            }
            else { // All other fields are tied, break ties by last name
                return $0.back! < $1.back!
            }
        }
        let currentCard = currentArray[pageController.currentPage]
        if(currentSide == 1){
            cardText.text = currentCard.back
            currentSide = -1
        }
        else{
            cardText.text = currentCard.front
            currentSide = 1

        }
    }
    @IBAction func slide(_ sender: Any?) {
        
        var currentArray = currentdeck.cards?.allObjects as! [Card]
         currentArray.sort {
            if $0.front != $1.front { // first, compare by last names
                return $0.front! < $1.front!
            }
            else { // All other fields are tied, break ties by last name
                return $0.back! < $1.back!
            }
        }
        pageController.numberOfPages = currentArray.count
        let currentCard = currentArray[pageController.currentPage]
        cardText.text = currentCard.front
        currentSide = 1
        
    }
    
    
    @IBAction func swipeRight(_ sender: Any) {
        var currentArray = currentdeck.cards?.allObjects as! [Card]
         currentArray.sort {
            if $0.front != $1.front { // first, compare by last names
                return $0.front! < $1.front!
            }
            else { // All other fields are tied, break ties by last name
                return $0.back! < $1.back!
            }
        }
        if(pageController.currentPage != 0){
            pageController.currentPage = pageController.currentPage-1
        
        pageController.numberOfPages = currentArray.count
        let currentCard = currentArray[pageController.currentPage]
        cardText.text = currentCard.front
            currentSide = 1}
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        var currentArray = currentdeck.cards?.allObjects as! [Card]
         currentArray.sort {
            if $0.front != $1.front { // first, compare by last names
                return $0.front! < $1.front!
            }
            else { // All other fields are tied, break ties by last name
                return $0.back! < $1.back!
            }
        }
        if(pageController.currentPage != pageController.numberOfPages-1){
            pageController.currentPage = pageController.currentPage+1
        
        pageController.numberOfPages = currentArray.count
        let currentCard = currentArray[pageController.currentPage]
        cardText.text = currentCard.front
            currentSide = 1}
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
