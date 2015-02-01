//
//  WAddGuestViewController.swift
//  Waiting
//
//  Created by Doug Guastaferro on 1/22/15.
//  Copyright (c) 2015 Doug Guastaferro. All rights reserved.
//

import Foundation


class WAddGuestViewController: UIViewController, UITextFieldDelegate{
    
    let PhoneRegex = "^((\\+)|(00))[0-9]{6,14}$"
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var noPhoneButton: UIButton!
    @IBOutlet weak var addingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var partySizeTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var editingGuest: WGuest? = nil{
        didSet{
            self.populateForEditingGuest();
        }
    }
    
    var isAddingGuest: Bool = false {
        didSet{
            if self.isAddingGuest{
                self.addingIndicator.startAnimating()
            }
            else{
                self.addingIndicator.stopAnimating()
            }
        }
    }
    
    var savedPhoneNumber: String?
    
    var hasPhoneNumber:Bool = true{
        didSet{
            self.phoneNumberTextField.enabled = self.hasPhoneNumber
            if self.hasPhoneNumber{
                if let savedNumber = self.savedPhoneNumber{
                    self.phoneNumberTextField.text = savedNumber
                }
                self.noPhoneButton.backgroundColor = UIColor.lightGrayColor()
                self.phoneNumberTextField.backgroundColor = UIColor.whiteColor()
            }
            else{
                if !self.phoneNumberTextField.text.isEmpty{
                    self.savedPhoneNumber = self.phoneNumberTextField.text
                }
                self.phoneNumberTextField.backgroundColor = UIColor.lightGrayColor()
                self.phoneNumberTextField.text = nil
                self.noPhoneButton.backgroundColor = self.addButton.backgroundColor
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateForEditingGuest();
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.nameTextField.becomeFirstResponder()
    }
    
    //MARK: Actions
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        if (self.isAddingGuest){
            return
        }
        
        self.addGuest()
    }
    
    @IBAction func noPhonePressed(sender: AnyObject) {
        self.hasPhoneNumber = !self.hasPhoneNumber
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch(textField){
        case self.nameTextField:
            self.partySizeTextField.becomeFirstResponder()
        case self.partySizeTextField:
            self.phoneNumberTextField.becomeFirstResponder()
        case self.phoneNumberTextField:
            self.view.endEditing(true)
            self.addGuest()
        default:
            println("Error: no text field found")
        }
        
        return true
    }
   
    //MARK: private methods
    
    private func addGuest(){
        if (self.isAddingGuest){
            return
        }
        
        self.isAddingGuest = true
        
        let errorStr = self.isValidInput()
        if (errorStr == nil){
            
            let guest = self.editingGuest ?? WGuest.createGuest()!
            
            guest.name = self.nameTextField.text
            guest.phoneNumber = self.phoneNumberTextField.text
            guest.timeAdded = NSDate()
            
            if let partySize = self.partySizeTextField.text.toInt(){
                guest.partySize = partySize
            }
            
            weak var weakSelf = self
            guest.saveInBackgroundWithBlock { (success, error) -> Void in
                self.isAddingGuest = false
                if (success && error == nil){
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else{
                    weakSelf?.showErrorAlert(nil)
                    println(error)
                }
            }
        }
        else{
            self.isAddingGuest = false
            self.showErrorAlert(errorStr)
        }
    }
    
    private func showErrorAlert(message: String?){
        let errorStr = message ?? "Unknown error. Please check your network connection and try again."
        
        let alertController = UIAlertController(title: "Couldn't add guest", message: errorStr, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertController.addAction(alertAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func isValidInput() -> String?{
        if (self.nameTextField.text.isEmpty){
            return "Please provide a guest name"
        }
        
        if (self.partySizeTextField.text.isEmpty){
            return "Please provide a party size"
        }
        
        let alphaNums = NSCharacterSet.decimalDigitCharacterSet()
        let partySizeInputSet = NSCharacterSet(charactersInString: self.partySizeTextField.text)
        
        if !alphaNums.isSupersetOfSet(partySizeInputSet){
            return "Party size must be a number"
        }
        
        if self.phoneNumberTextField.text.isEmpty && self.hasPhoneNumber{
            return "Must provide a phone number or specify no phone"
        }
        
        let phoneNumberInputSet = NSCharacterSet(charactersInString: self.phoneNumberTextField.text)
        
        if !alphaNums.isSupersetOfSet(phoneNumberInputSet){
            return "Enter phone number with just numbers. Ex 4085557499"
        }
        
        return nil
    }
    
    private func populateForEditingGuest(){
        if self.nameTextField == nil{
            return;
        }
        if let guest = self.editingGuest{
            self.nameTextField.text = guest.name
            self.partySizeTextField.text = "\(guest.partySize)"
            if guest.phoneNumber != nil && !guest.phoneNumber.isEmpty{
                self.hasPhoneNumber = true
                self.phoneNumberTextField.text = guest.phoneNumber
            }
            else{
                self.phoneNumberTextField.text = nil
                self.hasPhoneNumber = false
            }
            
            self.addButton.setTitle("Update", forState: .Normal)
        }
    }
    
    
}