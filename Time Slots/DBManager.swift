//
//  DBManager.swift
//  Time Slots
//
//  Created by Pawan kumar on 29/03/20.
//  Copyright © 2020 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

struct DBManager {
    
   static func getValueForKey(key: String) -> String
    {
        //Key Value in Local DB
        let value = UserDefaults.standard.value(forKey: key)
        if value == nil {
             return ""
        }
        print("DBManager getValueForKey ",key, (value as! String))
        return value as! String
    }
    
   static func setValueForKey(key: String, value: String) -> ()
    {
        //Key Value in Local DB
        print("DBManager setValueForKey ",key, value)
        UserDefaults.standard.set(value, forKey: key)
    }
    
    //Time Slots (Open-Close)
    static let dbTimeSlotsDay: String = "TimeSlotsDay"
    static let dbTimeSlotsDate: String = "TimeSlotsDate"
    static let dbTimeSlotsOpen: String = "TimeSlotsOpen"
    static let dbTimeSlotsLastClose: String = "TimeSlotsLastClose"
    static let dbTimeSlots: String = "TimeSlots"
    static let dbTimeSlotsDisplay: String = "TimeSlotsDisplay"
}
