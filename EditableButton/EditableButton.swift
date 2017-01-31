//
//  EditableButton.swift
//  EditableButton Demo App
//
//  Created by Nicolás Fernando Miari on 2017/01/31.
//  Copyright © 2017 Nicolas Miari. All rights reserved.
//

import UIKit

class EditableButton: UIButton {

    private var customInputView: UIView?

    override var inputView: UIView? {
        get {
            return customInputView
        }
        set (newValue) {
            customInputView = newValue
        }
    }

    private var customInputAccessoryView: UIView?

    override var inputAccessoryView: UIView? {
        get {
            return customInputAccessoryView
        }
        set (newValue) {
            customInputAccessoryView = newValue
        }
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    // MARK: Initialization

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.addTarget(self, action: #selector(EditableButton.tap(_:)), for: .touchDown)
    }

    deinit {
        print("Deinitializing Editable Button")
    }

    // MARK: - Control Actions

    @IBAction func tap(_ sender: UIButton) {
        self.becomeFirstResponder()
    }
}
