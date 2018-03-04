//
//  SettingsTableVC.swift
//  Magnetica
//
//  Created by Therese Henriksson (RIT Student) on 3/3/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import UIKit

class SettingsTableVC: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // ivar
    let familyNames = UIFont.familyNames
    let fontColors = [(name: "Black", value: UIColor.black), (name: "Blue", value: UIColor.blue),
                      (name: "Red", value: UIColor.red), (name: "Green", value: UIColor.green)]
    var magneticaVC: MagneticaVC!
    
    // outlets
    @IBOutlet weak var fontStylePicker: UIPickerView!
    @IBOutlet weak var fontColorPicker: UIPickerView!
    @IBOutlet weak var fontSizeOnChangeLabel: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fontStylePicker.delegate = self
        self.fontStylePicker.dataSource = self
        
        self.fontColorPicker.delegate = self
        self.fontColorPicker.dataSource = self
        
    }
    
    
    // Functions
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return familyNames.count
        } else {
            return fontColors.count
        }
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        if pickerView.tag == 1 {
            var fontStyleLabel: UILabel? = (view as? UILabel)
            
            if fontStyleLabel == nil {
                fontStyleLabel = UILabel()
                fontStyleLabel?.font = UIFont(name: familyNames[row], size: 16)
                fontStyleLabel?.textAlignment = .center
            }
            
            fontStyleLabel?.text = familyNames[row]
            fontStyleLabel?.textColor = UIColor.black

            return fontStyleLabel!
        } else {
            var fontColorLabel: UILabel? = (view as? UILabel)
            
            if fontColorLabel == nil {
                fontColorLabel = UILabel()
                fontColorLabel?.font = UIFont(name: "helvetica neue", size: 16)
                fontColorLabel?.textAlignment = .center
            }
            
            fontColorLabel?.text = fontColors[row].name
            fontColorLabel?.textColor = fontColors[row].value
            
            return fontColorLabel!
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 1 {
            selectBackgroundImage(self)
        }
        
    }
    
    @objc func selectBackgroundImage(_ sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("finished picking")
        let nCenter = NotificationCenter.default
        
        nCenter.post(name: backgroundImageChangedNotification, object: self, userInfo: info)
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled")
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // IBActions
    @IBAction func cancelTapped(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneTapped(sender: AnyObject) {
        //let nCenter = NotificationCenter.default
        
//        for wordTheme in wordManager.wordBank {
//
//            if (wordTheme.name == selectedWordTheme) {
//                let data = ["Theme": wordTheme.value]
//                nCenter.post(name: myWordThemeChangedNotification, object: self, userInfo: data)
//            }
//        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fontSizeOnChange(_ sender: UISlider) {
        fontSizeOnChangeLabel.text = String(round(sender.value))
        sender.setValue(round(sender.value), animated: true)
    }
    
    
}





