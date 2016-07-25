//
//  LoaderWorker.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit
import MBProgressHUD

//Class for showing full screen loader UI that everybody hates but which saves us on super slow internet connections
class LoaderWorker: NSObject {
    class func showLoaderOnView(view: UIView!){
        MBProgressHUD.showHUDAddedTo(view, animated: true)
    }

    class func hideLoaderFromView(view: UIView!){
        MBProgressHUD.hideHUDForView(view, animated: true)
    }
}