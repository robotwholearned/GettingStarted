//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Sandquist, Cassandra - Cassandra on 3/12/16.
//  Copyright © 2016 robotwholearned. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    @IBOutlet weak var saveButton: UIBarButtonItem!

    /*
    This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)` or constructed as part of adding a new meal.
    */
    var meal: Meal?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        checkValidMealName()
    }

    // MARK: Navigation
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender === saveButton {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating

            meal = Meal(name: name, photo: photo, rating: rating)

        }
    }


    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {

        //Hide the Keyboard
        nameTextField.resignFirstResponder()

        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()

        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary

        imagePickerController.delegate = self

        presentViewController(imagePickerController, animated: true) { () -> Void in

        }

    }

}

// MARK: UITextFieldDelegate
extension MealViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        //Hide the Keyboard
        textField.resignFirstResponder()

        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title = textField.text
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }

    func checkValidMealName() {
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
}

extension MealViewController: UIImagePickerControllerDelegate {
    // MARK: UIImagePickerControllerDelegate

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)

    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {

        // swiftlint:disable force_cast

        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage

        // swiftlint:enable force_cast

        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage

        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)

    }

}

extension MealViewController: UINavigationControllerDelegate {

}
