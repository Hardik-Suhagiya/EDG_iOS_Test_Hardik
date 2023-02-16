//
//  Utils.swift
//  EDG_iOS_Test
//
//  Created by Hardik's Mac on 16/02/23.
//

import Foundation

func getFavouriteList() -> [String]?{
    if let arrFav = UserDefaults.standard.value(forKey: "FavouriteList") as? [String]{
        return arrFav
    }
    return nil
}

func saveFavouriteList(arrFav:[String]){
    UserDefaults.standard.set(arrFav, forKey: "FavouriteList")
}
