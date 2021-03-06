//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Sandquist, Cassandra - Cassandra on 3/12/16.
//  Copyright © 2016 robotwholearned. All rights reserved.
//

import UIKit

enum RatingLevels: Int {
    case One = 1, Two, Three, Four, Five
}

struct MealNames {
    static let capreseSalad = "Caprese Salad"
    static let chickenAndPotatoes = "Chicken and Potatoes"
    static let pastaAndMeatballs = "Pasta with Meatballs"
}

class MealTableViewController: UITableViewController {

    //MARK: Properties
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem()

        if let loadedMeals = loadMeals() {
            meals += loadedMeals
        } else {
            loadSampleMeals()
        }
    }

    func loadSampleMeals() {
        let photo1 = R.image.meal1()
        let meal1 = Meal(name: MealNames.capreseSalad, photo: photo1, rating: RatingLevels.Four.rawValue)!

        let photo2 = R.image.meal2()
        let meal2 = Meal(name: MealNames.chickenAndPotatoes, photo: photo2, rating: RatingLevels.Five.rawValue)!

        let photo3 = R.image.meal3()
        let meal3 = Meal(name: MealNames.pastaAndMeatballs, photo: photo3, rating: RatingLevels.Three.rawValue)!

        meals += [meal1, meal2, meal3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.mealTableViewCell.identifier, forIndexPath: indexPath) as! MealTableViewCell

        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]

        cell.nameLabel.text = meal.name
        cell.photoImageView?.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }

    @IBAction func unwindToMealList (segue: UIStoryboardSegue) {
        if let sourceViewController = segue.sourceViewController as? MealViewController, meal = sourceViewController.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new meal.
                let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                meals.append(meal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }

            saveMeals()
        }
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            meals.removeAtIndex(indexPath.row)
            saveMeals()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == R.segue.mealTableViewController.showDetail.identifier {
            let mealDetailViewController = segue.destinationViewController as! MealViewController

            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            }

        } else if segue.identifier == R.segue.mealTableViewController.addItem.identifier {
            print("Adding new meal.")
        }
    }

    // MARK: NSCoding
    func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)

        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }
}
