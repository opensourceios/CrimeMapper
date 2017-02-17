//
//  DateController.swift
//  StopAndSearch
//
//  Created by edit on 21/01/2017.
//  Copyright © 2017 edit. All rights reserved.
//

import UIKit

protocol DateControllerDelegate: class {
  
  func didSetDate(date: MonthYear, isOn: Bool)
}

class DateController: UIViewController {
  
  var currentDate: MonthYear?
  var dateFilterIsOn: Bool?
  var delegate: DateControllerDelegate?
  let pickerData =  [Months.months,["2014","2015","2016"]]
  
  
  // done button
  
  @IBAction func didPressDone(_ sender: Any) {
    delegateAndDismiss()
  }
  
  func delegateAndDismiss() {
    let month  = datePicker.selectedRow(inComponent: 0)
    let yearAsString = pickerData[1][datePicker.selectedRow(inComponent: 1)]
    let year = Int(yearAsString)
    let date = MonthYear(month:month,  year : year! )
    delegate?.didSetDate(date: date, isOn: dateFilterIsOn ?? true)
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBOutlet weak var doneButton: UIButton!
  
  //labels

  @IBOutlet weak var instructionsLabel: UILabel!
  

  //containers
  
  @IBOutlet weak var titleViewContainer: UIView!
  @IBOutlet weak var pickerContainer: UIView!
  @IBOutlet weak var instructionsContainer: UIView!
  @IBOutlet weak var setDateSwitch: UISwitch!
  
  //picker
  @IBOutlet weak var datePicker: UIPickerView!
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    setPickerState(self.dateFilterIsOn!)
    datePicker.delegate = self
    datePicker.dataSource = self
    self.view.backgroundColor = .flatWhite
    doneButton.tintColor = .flatMintDark
    self.setToDate(currentDate)
  }
  
  func setToDate(_ date:MonthYear?) {
    if let d = date {
      datePicker.selectRow(d.month, inComponent: 0, animated: false)
      datePicker.selectRow(d.year - 2014, inComponent: 1, animated: false)
    }
  }
  
  func setPickerState (_ isOn: Bool) {
    
   
    datePicker.isUserInteractionEnabled = isOn
    if (isOn) {
    datePicker.alpha = 1
    instructionsContainer.backgroundColor  = UIColor.flatMint.withAlphaComponent(0.2)
   // pickerContainer.backgroundColor = .flatWhite
    instructionsLabel.text = "select date to filter crime data"
  
    } else {
    instructionsContainer.backgroundColor  = UIColor.flatGrayDark.withAlphaComponent(0.3)
   // pickerContainer.backgroundColor = UIColor.flatWhiteDark.withAlphaComponent(0.5)
    instructionsLabel.text = "not filtering by date"
       datePicker.alpha = 0.2
    }
  }
   
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension DateController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return pickerData.count
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData[component].count
  }
  
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    return NSAttributedString(string:  pickerData[component][row] , attributes: [NSForegroundColorAttributeName:UIColor.flatBlack])
  }
}





