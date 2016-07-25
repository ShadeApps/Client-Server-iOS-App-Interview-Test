//
//  KeyboardNotifier.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit

//Managing keyboard notifications and passing them on for view controllers, so they don't have to
protocol KeyboardNotifierDelegate: class {
    func animateKeyboardChanges(duration: Double?, frame: CGRect?, options: UInt?)
}

class KeyboardNotifier: NSObject {
    //It can only be one subscriber per class instance, beware!
    weak var delegate:KeyboardNotifierDelegate?
    var mainSubscriber: AnyObject?

    func subscribeForNotifs(subscriber: AnyObject?){
        mainSubscriber = subscriber

        //A lot of going on, while it's just simple keyboard changes for all possible states (experience + path of trial & error)
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: nil){ (notification : NSNotification?)in
            self.delegate?.animateKeyboardChanges(notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue, frame:notification?.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue, options:notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? UInt)
        }

        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: nil){ (notification : NSNotification?)in
            self.delegate?.animateKeyboardChanges(notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue, frame:CGRectZero, options:notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? UInt)
        }

        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil, queue: nil){ (notification : NSNotification?)in
            self.delegate?.animateKeyboardChanges(notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue, frame:notification?.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue, options:notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? UInt)
        }
    }

    func unsubscribeFromNotifs(subscriber: AnyObject?){
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}