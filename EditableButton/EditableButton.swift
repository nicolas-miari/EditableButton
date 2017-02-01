//
//  EditableButton.swift
//  EditableButton Demo App
//
//  Created by Nicolás Fernando Miari on 2017/01/31.
//  Copyright © 2017 Nicolas Miari. All rights reserved.
//

import UIKit

/**
 */
class EditableButton: UIButton, UITextInputTraits, UIKeyInput {

    // MARK: - UITextInputTraits

    var autocapitalizationType: UITextAutocapitalizationType = .none
    var autocorrectionType: UITextAutocorrectionType         = .no
    var spellCheckingType: UITextSpellCheckingType           = .no
    var enablesReturnKeyAutomatically: Bool                  = false
    var keyboardAppearance: UIKeyboardAppearance             = .default
    var keyboardType: UIKeyboardType                         = .default
    var returnKeyType: UIReturnKeyType                       = .default
    //var @objc(setSecureTextEntry:) isSecureTextEntry: Bool   = false
    var textContentType: UITextContentType!

    // MARK: - UIKeyInput

    public func deleteBackward() {
        guard let text = self.title(for: .normal), !text.isEmpty else {
            return
        }
        let newText = text[text.startIndex ..< text.index(before: text.endIndex)]
        updateTitle(text: newText)
    }

    public func insertText(_ text: String) {
        let existing = self.title(for: .normal) ?? ""
        let new = existing + text
        updateTitle(text: new)
    }

    public var hasText: Bool {
        let text = self.titleLabel?.text ?? ""
        return !(text.isEmpty)
    }

    // MARK: (UIKeyInput Support)
    /**
     Use this method instead of setTitle(_:) to avoid the fade animation when
     changing the label text.
     */
    private func updateTitle(text: String) {
        UIView.setAnimationsEnabled(false)
        self.setTitle(text, for: .normal)
        if self.buttonType == .system {
            self.layoutIfNeeded()
        }
        UIView.setAnimationsEnabled(true)
        // (Taken form here: http://stackoverflow.com/a/19303693/433373)
    }

    // MARK: - UIResponder

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

    // MARK: - Initialization

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
