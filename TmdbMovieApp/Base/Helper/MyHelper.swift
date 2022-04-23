//
//  Helper.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 23.04.2022.
//

import Foundation

class MyHelper {
    
    // For Date formatter to "dd.mm.yyyy"
    let formatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd.MM.yyyy"

           // make sure the following are the same as that used in the API
           formatter.timeZone = TimeZone(secondsFromGMT: 0)
           formatter.locale = Locale.current

           return formatter
       }()
}
