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
    var fontStyle:String = Constants.MagneticaConstants.defaultFontStyle
    var fontSize: Int = 0
    var backgroundColor: UIColor = Constants.MagneticaConstants.defaultBackgroundColor
    
    let backgroundColors = [(name: "Black", value: UIColor.black), (name: "Blue", value: UIColor.blue),
                      (name: "Red", value: UIColor.red), (name: "Green", value: UIColor.green),
                      (name: "Browm", value: UIColor.brown), (name: "Cyan", value: UIColor.cyan),
                      (name: "Dark Gray", value: UIColor.darkGray), (name: "Light Gray", value: UIColor.lightGray),
                      (name: "White", value: UIColor.white), (name: "Orange", value: UIColor.orange),
                      (name: "Purple", value: UIColor.purple), (name: "Magenta", value: UIColor.magenta),
                      (name: "Yellow", value: UIColor.yellow)]
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
        
        magneticaVC = MagneticaVC()
        fontSizeSlider.value = Float(magneticaVC.fontSize)
        fontSize = magneticaVC.fontSize
        fontSizeOnChangeLabel.text = String(magneticaVC.fontSize)
        
        
        for (index, font) in familyNames.enumerated() {
            if font == magneticaVC.fontStyle {
                fontStylePicker.selectRow(index, inComponent: 0, animated: true)
            }
        }

        
        for (index, color) in backgroundColors.enumerated() {
            if color.value == magneticaVC.backgroundColor {
                fontColorPicker.selectRow(index, inComponent: 0, animated: true)
            }
        }
    }
    
    // Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // The number of rows of data
        if pickerView.tag == 1 {
            return familyNames.count
        } else {
            return backgroundColors.count
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
            var backgroundColorLabel: UILabel? = (view as? UILabel)
            
            if backgroundColorLabel == nil {
                backgroundColorLabel = UILabel()
                backgroundColorLabel?.font = UIFont(name: Constants.MagneticaConstants.defaultFontStyle, size: 16)
                backgroundColorLabel?.textAlignment = .center
            }
            
            backgroundColorLabel?.text = backgroundColors[row].name
            if backgroundColors[row].name == "White" {
                backgroundColorLabel?.textColor = UIColor.black
            } else {
                backgroundColorLabel?.textColor = backgroundColors[row].value
            }
            
            return backgroundColorLabel!
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // use the row to get the selected row from the picker view
        // using the row extract the value from your datasource (array[row])
        
        if pickerView.tag == 1 {
            fontStyle = familyNames[row]
        } else {
            backgroundColor = backgroundColors[row].value
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
    
    //MARK -Imagepicker-
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        let nCenter = NotificationCenter.default
        
        nCenter.post(name: backgroundImageChangedNotification, object: self, userInfo: info)
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    // IBActions
    @IBAction func cancelTapped(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneTapped(sender: AnyObject) {
        let nCenter = NotificationCenter.default
        
        let dataFontStyle = ["Style": fontStyle]
        let dataFontSize = ["Size": fontSize]
        let dataBackgroundColor = ["Color": backgroundColor]
        
        nCenter.post(name: fontStyleChangedNotification, object: self, userInfo: dataFontStyle)
        nCenter.post(name: fontSizeChangedNotification, object: self, userInfo: dataFontSize)
        nCenter.post(name: backgroundColorChangedNotification, object: self, userInfo: dataBackgroundColor)
        nCenter.post(name: updateScreenNotification, object: self, userInfo: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fontSizeOnChange(_ sender: UISlider) {
        fontSizeOnChangeLabel.text = String(round(sender.value))
        fontSize = Int(round(sender.value))
        sender.setValue(round(sender.value), animated: true)
    }
    
    // IBActions
    @IBAction func removeBackgroundImage(sender: AnyObject) {
        let nCenter = NotificationCenter.default
        
        nCenter.post(name: removeBackgroundImageNotification, object: self)
    }
    
    
}





