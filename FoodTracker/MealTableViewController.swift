//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by James Carlson on 11/5/16.
//  Copyright © 2016 James Carlson. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load saved meals otherwise load the sample data
        if let savedMeals = loadMeals() {
            meals += savedMeals
        } else {
            // Add sample data
            loadSampleMeals()
        }
        
    }
    
    func loadSampleMeals() {
        let photo1 = UIImage(named: "burger")
        let meal1 = Meal(name: "Burger", photo: photo1, rating: 5)!
        
        let photo2 = UIImage(named: "pasta")
        let meal2 = Meal(name: "Pasta", photo: photo2, rating: 3)!
        
        let photo3 = UIImage(named: "chicken")
        let meal3 = Meal(name: "Chicken", photo: photo3, rating: 4)!
        
        meals += [meal1, meal2, meal3]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealTableViewCell
        
        // Gets the meal for the index, and sets the data in the UI
        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Save the new meals arr
            saveMeals()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowDetail" {
            let mealDetailViewController = segue.destination as! MealViewController
            
            // Get the cell that generated this segue
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPath(for: selectedMealCell)
                let selectedMeal = meals[(indexPath?.row)!]
                mealDetailViewController.meal = selectedMeal
            }
            
        } else if segue.identifier == "AddItem" {
            print("Adding new meal")
        }
        
    }
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            
            // Checks whether a row of the tableview was selected, if not add a new meal
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Update exisitng meal
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            } else {
                
                // Add new meal
                let newIndexPath = NSIndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath as IndexPath] , with: .bottom)
            }
        }
        
        // Save the meals to disk, whenever a new one is added or edited
        saveMeals()
    }
    
    // NSConfig
    
    func saveMeals() {
        
        // Saves meals to a specific location and returns true if its successful
        let isSuccesfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.archiveURL.path)
        
        if !isSuccesfulSave {
            print("Failed to save meals")
        }
    }
    
    func loadMeals()->[Meal]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.archiveURL.path) as? [Meal]
    }
}
