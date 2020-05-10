//
//  Deck View.swift
//  Flash Cards
//
//  Created by Varun Chitturi on 4/28/20.
//  Copyright © 2020 School Works. All rights reserved.
//

import UIKit
import CoreData
class Deck_View: UITableViewController {
    var deckObject = [Deck]()
    var whichSegue = 0
    // 0 for viewing deck
    // 1 for create Deck
    // 2 for edit Deck
    override func viewDidLoad() {
        
                super.viewDidLoad()
        self.tableView.dataSource = self;
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       //self.navigationItem.rightBarButtonItem = self.editButtonItem
       
    }
    
    @IBAction func createADeckSegue(_ sender: Any) {
        whichSegue = 1
        performSegue(withIdentifier: "editDeckSegue", sender: nil)
    }
    func getDecks(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
            if let decksFromCoreData = try? context.fetch(Deck.fetchRequest()){
                let DeckFromCore = decksFromCoreData as! [Deck]
                print ()
                deckObject = DeckFromCore
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        getDecks()
        tableView.reloadData()
        
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
        return deckObject.count
       
    }

    @IBAction func unwind(_ seg: UIStoryboardSegue){
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deck", for: indexPath)
        cell.textLabel?.text = deckObject[indexPath.row].name
        
        // Configure the cell...

        return cell
    }
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               //let selectedJoke = jokes[indexPath.row]
               //let answer = answers[indexPath.row]
               //let question = questions[indexPath.row]
               let final =  deckObject[indexPath.row]
               let send = final
                whichSegue = 0
                performSegue(withIdentifier: "moveToDeckPageView", sender: send)
               
               
           }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(whichSegue == 0){
        if let deckVC = segue.destination as? viewDeckFlashCards{
               if let send = sender as? Deck{
                   deckVC.currentdeck = send            }
               
               
            }
            
        }
        else if whichSegue == 2{
            if let editDeckVC = segue.destination as? Deck_Creator{
               if let send = sender as? Deck{
                editDeckVC.isEditingDeck = true
                editDeckVC.firstLoad = true
                editDeckVC.editingDeck = send            }
               
               
            }
        }
        else{
            
        }
       }
    
    /*
    // Override to support conditional  editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
   
    
    
    
    
  

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        

        //Check condition and change value of jobStatus

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                let new = self.deckObject[indexPath.row]
                self.deckObject.remove(at: indexPath.row)
                                 context.delete(new)
                                 (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                self.getDecks()
                                 
                             }
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
           

        )
    
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                //do segue here
            let final =  self.deckObject[indexPath.row]
            let send = final
            self.whichSegue = 2
            self.performSegue(withIdentifier: "editDeckSegue", sender: send)
                    
            })

            //editAction.backgroundColor = UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
            return UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
