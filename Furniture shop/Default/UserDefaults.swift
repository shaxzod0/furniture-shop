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
    let nameKey = "name"
    let addressKey = "address"
    let pictureKey = "avatar"
    static let shared = UserDefaultsManager()
    
    func saveAuth(reg: Bool?){
        defaults.set(reg, forKey: authKey)
    }
    func isReg()->Bool{
        return defaults.bool(forKey: authKey) ?? false
    }
    func saveName(name: String?){
        defaults.set(name, forKey: nameKey)
    }
    func getName()->String{
        return defaults.string(forKey: nameKey) ?? "User"
    }
    func saveAddress(address: String?){
        defaults.set(address, forKey: addressKey)
    }
    func getAddress()->String{
        return defaults.string(forKey: addressKey) ?? "example@gmail.com"
    }
    func saveProfileImage(address: URL?){
        defaults.set(address, forKey: pictureKey)
    }
    func getProfileImage()->URL{
        return defaults.url(forKey: pictureKey) ?? URL(string: "https://picsum.photos/200")!
    }
}
