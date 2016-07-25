//
//  DataEncryptor.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit

//Encrypting saved data to disk so no one (but us) could read it
class DataEncryptor: NSObject {
   class func encryptedString(originalString: String) -> String {
        do {
            let encrypted = try originalString.aesEncrypt(CryptoKeys.MainKey, iv: CryptoKeys.IVKey)
            return encrypted
        } catch {
            return ""
        }
    }
}
