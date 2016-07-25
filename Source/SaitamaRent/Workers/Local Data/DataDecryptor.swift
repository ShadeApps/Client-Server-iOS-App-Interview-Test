//
//  DataDecryptor.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit

//Decrypting saved data to disk so we could read it
class DataDecryptor: NSObject {
    class func decryptedString(originalString: String) -> String {
        do {
            let decrypted = try originalString.aesDecrypt(CryptoKeys.MainKey, iv: CryptoKeys.IVKey)
            return decrypted
        } catch {
            return ""
        }
    }
}
