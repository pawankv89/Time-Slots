//
//  ViewController.swift
//  Time Slots
//
//  Created by Pawan kumar on 29/03/20.
//  Copyright © 2020 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, BookingTimeSlotsDelegate {
    
    var bookingTimeSlots: BookingTimeSlots!
    
    //Open Time
    @IBOutlet weak var openLabel: UILabel!
    
    //Close Time
    @IBOutlet weak var closeLabel: UILabel!
    
    //Selected Time Slot
    @IBOutlet weak var selectedTimeSlotLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Time Slots (Open-Close)
        //DBManager.setValueForKey(key: DBManager.dbTimeSlotsDay, value: "Now")
        //DBManager.setValueForKey(key: DBManager.dbTimeSlotsDate, value: "2020-03-23")
        //DBManager.setValueForKey(key: DBManager.dbTimeSlotsOpen, value: "08:00pm")
        //DBManager.setValueForKey(key: DBManager.dbTimeSlotsLastClose, value: "08:30pm")
        
    }
    
    @IBAction func timeSlotsButtonTap(_ sender: UIButton)-> () {
        self.showBookingTimeSlots()
    }
    
    //Start ---- BookingTimeSlots ----
       
       @objc func showBookingTimeSlots() -> Void {
           
           DispatchQueue.main.async {
               
               //Clear old No Data View
               if self.bookingTimeSlots != nil {
                   if self.bookingTimeSlots.view != nil {
                       self.bookingTimeSlots.view.removeFromSuperview()
                       self.bookingTimeSlots.removeFromSuperview()
                   }
               }
               
               //When Blank Array Recived here
               let frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
               self.bookingTimeSlots = BookingTimeSlots.init(frame: frame)
               self.bookingTimeSlots.delegate = self
               self.bookingTimeSlots.center = self.view.center
               
               //Add ViewController
               UIApplication.shared.keyWindow?.addSubview(self.bookingTimeSlots.view)
           }
       }
       
       func bookingTimeSlotsSubmitButton(date: String) {
           
           DispatchQueue.main.async {
               
               //Time Slots (Open-Close)
               let timeSlotsDay = DBManager.getValueForKey(key: DBManager.dbTimeSlotsDay)
               let timeSlotsDate = DBManager.getValueForKey(key: DBManager.dbTimeSlotsDate)
               let timeSlotsOpen = DBManager.getValueForKey(key: DBManager.dbTimeSlotsOpen)
               let timeSlotsLastClose = DBManager.getValueForKey(key: DBManager.dbTimeSlotsLastClose)
               let timeSlotsDisplay = DBManager.getValueForKey(key: DBManager.dbTimeSlotsDisplay)
               
               self.selectedTimeSlotLabel.text = timeSlotsDisplay
           
               //Clear old No Data View
               if self.bookingTimeSlots != nil {
                   if self.bookingTimeSlots.view != nil {
                       self.bookingTimeSlots.view.removeFromSuperview()
                       self.bookingTimeSlots.removeFromSuperview()
                   }
               }
           }
       }
       
       //End ---- BookingTimeSlots ----
    
}

