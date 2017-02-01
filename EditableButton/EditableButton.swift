//
//  EditableButton.swift
//  EditableButton Demo App
//
//  Created by Nicolás Fernando Miari on 2017/01/31.
//  Copyright © 2017 Nicolas Miari. All rights reserved.
//

import UIKit

/**
 UIButton subclass whose title label text can be edited using the system 
 keyboard, just like a text field.
 
 By adopting the protocols `UIKeyInput` and `UITextInputTraits`, and being able 
 to become first responder, the system keyboard is displayed when the button is
 tapped.

 Like text fields and text views, it also supports setting up a custom input 
 view (for exmple, a date picker or a generic picker view) and an input 
 accessory view (for example, a toolbar with 'done' and/or 'cancel' buttons to
 dismiss the input view).
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

    /// Provides storage to override the read-only property `inputView`.
    private var customInputView: UIView?

    /// Overrides the base class' read-only property to make it read-write.
    override var inputView: UIView? {
        get {
            return customInputView
        }
        set (newValue) {
            customInputView = newValue
        }
    }

    /// Provides storage to override the read-only property `inputAccessoryView`.
    private var customInputAccessoryView: UIView?

    /// Overrides the base class' read-only property to make it read-write.
    override var inputAccessoryView: UIView? {
        get {
            return customInputAccessoryView
        }
        set (newValue) {
            customInputAccessoryView = newValue
        }
    }

    /// `UIButton` returns `false`. This implementation returns `true` so the 
    /// button can be edited.
    override var canBecomeFirstResponder: Bool {
        return true
    }

    // MARK: - Initialization

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Setup self as target of button action, so we can call
        // becomeFirstResponder() on tap and begin editing:

        self.addTarget(self, action: #selector(EditableButton.tap(_:)), for: .touchDown)

        // Perhaps it is better to just override sendAction(_:to:for:)?
        // https://developer.apple.com/reference/uikit/uicontrol
    }

    deinit {
        print("Deinitializing Editable Button")
    }

    // MARK: - Control Actions

    @IBAction func tap(_ sender: UIButton) {
        self.becomeFirstResponder()
    }
}
