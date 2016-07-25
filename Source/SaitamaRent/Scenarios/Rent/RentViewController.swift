//
//  RentViewController.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 27.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit
import Caishen
import EZAlertController

class RentViewController: UIViewController, UITextFieldDelegate, CardTextFieldDelegate, CardIOPaymentViewControllerDelegate {
    @IBOutlet weak var rentButton: UIButton?
    @IBOutlet weak var cardNumberTextField: CardTextField!
    @IBOutlet weak var txtName: UITextField!
    var isValid : Bool = false
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.delegate = self
        cardNumberTextField.cardTextFieldDelegate = self
    }

    // MARK: - Input Actions
    @IBAction func btnRentTapped(sender: AnyObject) {
        self.view.endEditing(true)
        LoaderWorker.showLoaderOnView(self.view)
        RentNetWorker.rentWithData(cardNumberTextField.numberInputTextField.text, name: txtName.text, expiration:"\(cardNumberTextField.monthTextField.text)/\(cardNumberTextField.yearTextField.text)", code: cardNumberTextField.cvcTextField.text){(isDone, errorText) in
            if !isDone {
                EZAlertController.alert(NSLocalizedString(UIStrings.ServerError, comment: ""), message: (errorText != nil) ?errorText! : NSLocalizedString(UIStrings.ServerErrorLong, comment: ""))
                return
            }else{
                LoaderWorker.hideLoaderFromView(self.view)
                self.dismissViewControllerAnimated(true){
                    EZAlertController.alert(NSLocalizedString(UIStrings.RentSuccessAlertTitle, comment: ""), message:NSLocalizedString(UIStrings.RentSuccessAlertBody, comment: ""))
                }
            }
        }
    }

    @IBAction func btnCancelTapped(sender: AnyObject) {
        self.view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - CardNumberTextField & UITextField delegate methods
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        rentButton?.enabled = isValid && self.txtName.text!.characters.count > 4
        return true
    }

    func cardTextField(cardTextField: CardTextField, didEnterCardInformation information: Card, withValidationResult validationResult: CardValidationResult) {
        isValid = validationResult == .Valid
        rentButton?.enabled = isValid && self.txtName.text!.characters.count > 4
    }

    func cardTextFieldShouldShowAccessoryImage(cardTextField: CardTextField) -> UIImage? {
        return UIImage(named: UIKeys.CamIconTitle)
    }

    func cardTextFieldShouldProvideAccessoryAction(cardTextField: CardTextField) -> (() -> ())? {
        return { [weak self] _ in
            let cardIOViewController = CardIOPaymentViewController(paymentDelegate: self)
            self?.presentViewController(cardIOViewController, animated: true, completion: nil)
        }
    }

    // MARK: - Card.io delegate methods
    func userDidCancelPaymentViewController(paymentViewController: CardIOPaymentViewController!) {
        paymentViewController.dismissViewControllerAnimated(true, completion: nil)
    }

    func userDidProvideCreditCardInfo(cardInfo: CardIOCreditCardInfo!, inPaymentViewController paymentViewController: CardIOPaymentViewController!) {
        cardNumberTextField.prefillCardInformation(cardInfo.cardNumber, month: Int(cardInfo.expiryMonth), year: Int(cardInfo.expiryYear), cvc: cardInfo.cvv)
        paymentViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}