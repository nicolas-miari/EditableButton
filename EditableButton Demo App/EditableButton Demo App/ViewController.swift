//
//  ViewController.swift
//  EditableButton Demo App
//
//  Created by Nicolás Fernando Miari on 2017/01/31.
//  Copyright © 2017 Nicolas Miari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateButton: EditableButton!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateButton.setTitle(dateFormatter.string(from: Date()), for: .normal)

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        //dateButton.inputView = datePicker
        datePicker.addTarget(self, action: #selector(ViewController.dateChanged(_:)), for: .valueChanged)

        let dateToolbar = UIToolbar(frame: CGRect.zero)
        dateToolbar.barStyle = .default

        let dateDoneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(ViewController.dateDone(_:)))
        let dateSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        dateToolbar.items = [dateSpacer, dateDoneButton]
        dateToolbar.sizeToFit()

        dateButton.inputAccessoryView = dateToolbar
    }

    // MARK: - Control Actions

    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateButton.setTitle(dateFormatter.string(from: sender.date), for: .normal)
    }

    @IBAction func dateDone(_ sender: UIBarButtonItem) {
        dateButton.resignFirstResponder()
    }
}
