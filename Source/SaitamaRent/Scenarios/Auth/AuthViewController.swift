//
//  AuthViewController.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit
import EZAlertController

class AuthViewController: UIViewController, KeyboardNotifierDelegate, UITextFieldDelegate {
    var mainKeyboardNotifier: KeyboardNotifier?
    var originalCenterYConstant: CGFloat = 0.0

    @IBOutlet weak var centerYConstant: NSLayoutConstraint!
    @IBOutlet weak var topYConstant: NSLayoutConstraint!

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainKeyboardNotifier = KeyboardNotifier()
        mainKeyboardNotifier?.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(AuthViewController.reactToTap(_:))))
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.endEditing(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        mainKeyboardNotifier?.subscribeForNotifs(self)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        originalCenterYConstant = centerYConstant.constant
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        mainKeyboardNotifier?.unsubscribeFromNotifs(self)
    }

    // MARK: - Input Actions
    func reactToTap(sender: AnyObject?){
        self.view.endEditing(true)
    }

    // MARK: Handling UITextField return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.isEqual(self.txtEmail){
             self.txtPass.becomeFirstResponder()
        }else{
            self.btnLogInTapped(nil)
        }
        return true
    }

    // MARK: Logging in
    @IBAction func btnLogInTapped(sender: UIButton?){
        self.view.endEditing(true)
        DataValidator.validateAuthData(self.txtEmail.text!, password: self.txtPass.text!){ (isValid) in
            if !isValid{
                EZAlertController.alert(NSLocalizedString(UIStrings.WrongData, comment: ""), message: NSLocalizedString(UIStrings.WrongDataLong, comment: ""))
                return
            }

            LoaderWorker.showLoaderOnView(self.navigationController?.view)

            AuthNetWorker.loginWithData(self.txtEmail.text, pass: self.txtPass.text, completionHandler: { (isDone, errorText) in
                LoaderWorker.hideLoaderFromView(self.navigationController?.view)
                if !isDone {
                    EZAlertController.alert(NSLocalizedString(UIStrings.ServerError, comment: ""), message: (errorText != nil) ?errorText! : NSLocalizedString(UIStrings.ServerErrorLong, comment: ""))
                    return
                }

                StoryboardConfigurator.configureAppUI()
            })
        }
    }
    
    // MARK: - Delegates
    func animateKeyboardChanges(duration: Double?, frame: CGRect?, options: UInt?) {
        UIView.animateWithDuration(duration!, delay: 0.0, options: [UIViewAnimationOptions(rawValue: options!), .BeginFromCurrentState], animations: { _ in
            self.centerYConstant?.constant = -frame!.height + self.originalCenterYConstant
            self.topYConstant?.constant = (frame!.height > 0) ? -self.topView.frame.height : 0
            self.topView?.alpha = (frame!.height > 0) ? 0 : 1.0
            self.view.layoutIfNeeded()
            },completion:nil)
    }
}