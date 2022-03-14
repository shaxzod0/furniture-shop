//
//  UserDefaults.swift
//  Furniture shop
//
//  Created by Shaxzod Azamatjonov on 14/03/22.
//

import UIKit

class UserDefaultsManager{
    let defaults = UserDefaults.standard
    let authKey = "auth"
    static let shared = UserDefaultsManager()
    
    func saveAuth(reg: Bool?){
        defaults.set(reg, forKey: authKey)
    }
    func isReg()->Bool{
        return defaults.bool(forKey: authKey) ?? false
    }
}
