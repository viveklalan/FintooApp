//
//  YourInfoVC.swift
//  FintooApp
//
//  Created by Jai Mataji on 13/03/21.
//

import UIKit
import SkyFloatingLabelTextField
import RSSelectionMenu

class YourInfoVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var investmentForTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var fixedLabel: UILabel!
    @IBOutlet weak var equityTypeSwitch: UISwitch!
    @IBOutlet weak var variableLabel: UILabel!
    @IBOutlet weak var dateOfPurchaseTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var noOfUnitsTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var purchasePriceTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var addMoreButton: UIButton!
    
    let investmentOptionArray = ["Self", "Wife", "Family"]
    var purchaseDatePicker = UIDatePicker()
    
    let switchColor = UIColor(red: 20/255, green: 81/255, blue: 101/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsOnViewLoad()
    }
    
    func setupViewsOnViewLoad(){
        /*For on state*/
        equityTypeSwitch.onTintColor = switchColor

        /*For off state*/
        equityTypeSwitch.tintColor = switchColor
        equityTypeSwitch.layer.cornerRadius = equityTypeSwitch.frame.height / 2.0
        equityTypeSwitch.backgroundColor = switchColor
        equityTypeSwitch.clipsToBounds = true
        
        investmentForTextField.titleFont = UIFont.systemFont(ofSize: 12)
        dateOfPurchaseTextField.titleFont = UIFont.systemFont(ofSize: 12)
        noOfUnitsTextField.titleFont = UIFont.systemFont(ofSize: 12)
        purchasePriceTextField.titleFont = UIFont.systemFont(ofSize: 12)
        
        addMoreButton.addRadius(brRadius: 8)
        
        addDatePicker()
        purchasePriceTextField.delegate = self
    }
    
    //MARK: BUtton Actions
    @IBAction func investmentForClicked(_ sender: Any) {
        let selectionMenu = RSSelectionMenu(selectionStyle: .single, dataSource: investmentOptionArray) { (cell, data, indexPath) in
            cell.textLabel?.text = data
            cell.tintColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        }
        selectionMenu.show(style: .actionSheet(title: "Who is this investment for?", action: "Done", height: nil), from: self)
        selectionMenu.onDismiss = { selectedItems in
            self.investmentForTextField.text = selectedItems.first
        }
    }
    
    @IBAction func equityTypeSwitchClicked(_ sender: Any) {
        if equityTypeSwitch.isOn{
            fixedLabel.font = UIFont.systemFont(ofSize: 14)
            variableLabel.font = UIFont.boldSystemFont(ofSize: 14)
        }else{
            fixedLabel.font = UIFont.boldSystemFont(ofSize: 14)
            variableLabel.font = UIFont.systemFont(ofSize: 14)
        }
    }
    
    @IBAction func addMoreClicked(_ sender: Any) {
        if investmentForTextField.text! == ""{
            self.showAlert(title: "Error", message: "Please select who is this investment for?")
            return
        }
        if dateOfPurchaseTextField.text! == ""{
            self.showAlert(title: "Error", message: "Please select date of purchase")
            return
        }
        if noOfUnitsTextField.text! == ""{
            self.showAlert(title: "Error", message: "Please enter no. of unit")
            return
        }
        if purchasePriceTextField.text! == ""{
            self.showAlert(title: "Error", message: "Please enter purchase price")
            return
        }
        
        //If all fields availbale call api and show response
        self.showAlert(title: "Thank you", message: "Record added successfully.")
        investmentForTextField.text = ""
        dateOfPurchaseTextField.text = ""
        noOfUnitsTextField.text = ""
        purchasePriceTextField.text = ""
    }
    
    func showAlert(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //adding date picker to textfields
    func addDatePicker(){
        //Formate Date
        purchaseDatePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            purchaseDatePicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            purchaseDatePicker.preferredDatePickerStyle = .wheels
        }
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        purchaseDatePicker.minimumDate = Date()
        dateOfPurchaseTextField.inputAccessoryView = toolbar
        dateOfPurchaseTextField.inputView = purchaseDatePicker
    }
    
    //MARK: toolbar actions
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        dateOfPurchaseTextField.text = formatter.string(from: purchaseDatePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}

//MARK: TextField Delegate
extension YourInfoVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let newText = text.replacingCharacters(in: range, with: string)
        if let regex = try? NSRegularExpression(pattern: "^[0-9]*((\\.|,)[0-9]{0,2})?$", options: .caseInsensitive) {
            return regex.numberOfMatches(in: newText, options: .reportProgress, range: NSRange(location: 0, length: (newText as NSString).length)) > 0
        }
        return false
    }
}
