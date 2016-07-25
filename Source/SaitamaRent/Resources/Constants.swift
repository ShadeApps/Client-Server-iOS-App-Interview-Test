//
//  Constants.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import Foundation

struct StoryboardID {
    static let Main = "Main"
    static let Auth = "Auth"
    static let Rent = "Rent"
}

struct UIKeys {
    static let MainColor = "#D30000"
    static let MapIconTitle = "imgLocIcon"
    static let CamIconTitle = "imgCamIcon"
}

struct UIStrings {
    static let WrongData = "WrongData"
    static let WrongDataLong = "WrongDataLong"

    static let ServerError = "ServerError"
    static let ServerErrorLong = "ServerErrorLong"

    static let LogOut = "LogOut"
    static let LogOutLong = "LogOutLong"

    static let LogOutOptionYes = "LogOutOptionYes"
    static let LogOutOptionNo = "LogOutOptionNo"

    static let RentBikeAlertTitle = "RentBikeAlertTitle"
    static let RentBikeAlertBody = "RentBikeAlertBody"
    static let RentBikeOptionNo = "RentBikeOptionNo"
    static let RentBikeOptionYes = "RentBikeOptionYes"

    static let RentBikeTitle = "RentBikeTitle"

    static let RentSuccessAlertTitle = "RentSuccessAlertTitle"
    static let RentSuccessAlertBody = "RentSuccessAlertBody"
}

struct NetStrings {
    static let MainHost = "http://localhost:8080/"
    static let SuccessCode = 200

    struct Path {
        static let Auth = NetStrings.MainHost+"api/v1/auth"
        static let Register = NetStrings.MainHost+"api/v1/register"
        static let Places = NetStrings.MainHost+"api/v1/places"
        static let Rent = NetStrings.MainHost+"api/v1/rent"
    }

    struct Params {
        static let Email = "email"
        static let Pass = "password"
        static let Token = "accessToken"
        static let Authorization = "Authorization"
        static let Results = "results"
        static let Number = "number"
        static let Name = "name"
        static let Expiration = "expiration"
        static let Code = "code"
    }
}

struct CryptoKeys {
    static let MainKey = "Ko5enI555eOsD7rQpagb6Pc0BfG1Q5ek"
    static let IVKey = "0123456789012345"
}

struct PersistorKeys {
    static let TokenKey = "SavedToken"
    static let EmailKey = "SavedEmail"
    static let ResultsKey = "SavedResults"
}

struct GMapsKeys{
    static let APIKey = "AIzaSyAwuq8_jZtA2o9JJyjIAfBe9lTQgIPTvxk"
}