//
//  Deck Creator.swift
//  Flash Cards
//
//  Created by Varun Chitturi on 4/28/20.
//  Copyright © 2020 School Works. All rights reserved.
//

import UIKit
import CoreData
class CardView : UITableViewCell{
    
    @IBOutlet weak var front: UITextField!
    @IBOutlet weak var back: UITextField!
    
}
class Deck_Creator: UITableViewController {
    static var count = 0
    var isEditingDeck = false
    var editingDeck = Deck()
    var firstLoad = false
    var cardCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardCount = 1
        
        if(isEditingDeck == true){
            cardCount = editingDeck.cards?.count as! Int
            
            
        }
        
     
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //showCancelPopUp.addTarget(self, action: #selector(showCancelPopUp), for: .touchUpInside)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if isEditingDeck == true{
            deckName.text = editingDeck.name
        }
       
    }
  
    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return cardCount
    }

    @IBAction func AddaCardbutton(_ sender: Any) {
        cardCount = cardCount + 1
        firstLoad = false
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "card", for: indexPath) as! CardView
        if(isEditingDeck == true && firstLoad == true){
        var cardArray = editingDeck.cards?.allObjects as! [Card]
        cardArray.sort {
                   if $0.front != $1.front {
                       return $0.front! < $1.front!
                   }
                   else {
                       return $0.back! < $1.back!
                   }
               }
            if(isEditingDeck == true && indexPath.row < cardArray.count && firstLoad == true){
            
                cell.front.text = cardArray[indexPath.row].front
                cell.back.text = cardArray[indexPath.row].back
            
            }
            
            
            
        }
        
        if(firstLoad == false){
            if(indexPath.row == cardCount-1){
                cell.front.text = ""
                cell.back.text = ""
            }
        }
        //do Array work here
        
        return cell
    }
    
    
  
    
    @IBOutlet weak var deckName: UITextField!
    
    @IBAction func finsishCreatingCards(_ sender: Any) {
       
        let cells = self.tableView.visibleCells
        
        
      
        
        // do saving context here.
        if(isEditingDeck == false){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            let deck = Deck(context: context)
            for cell in cells{
                let current = cell as! CardView
                let card = Card(context: context)
                card.front = current.front.text
                card.back = current.back.text
                deck.addToCards(card)
            }
            deck.name = deckName.text
        }
        //let finalData = joke()
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()}
        else{
            editingDeck.cards = NSSet()
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
               
                for cell in cells{
                    let current = cell as! CardView
                    let card = Card(context: context)
                    card.front = current.front.text
                    card.back = current.back.text
                    editingDeck.addToCards(card)
                }
                editingDeck.name = deckName.text
            }
            //let finalData = joke()
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        
        
        
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func showCancelPopUp(){
        let alertView = UIAlertController(title: "Discard Changes?", message: "All changes will be lost", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alertView.addAction(UIAlertAction(title: "Discard", style: .destructive, handler: { (_) in
            
            self.navigationController?.popViewController(animated: true)
            self.isEditingDeck = false
        }))
        
        self.present(alertView,animated: true,completion:nil)
    }
    
    
    
    @IBAction func cancelCreateDeck(_ sender: Any) {
       
        showCancelPopUp()
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cardCount -= 1
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    */

}
