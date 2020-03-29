# Time-Slots

## Time-Slots


Added Some screens here.

![](https://github.com/pawankv89/Time-Slots/blob/master/images/screen_1.png)
![](https://github.com/pawankv89/Time-Slots/blob/master/images/screen_2.png)
![](https://github.com/pawankv89/Time-Slots/blob/master/images/screen_3.png)
![](https://github.com/pawankv89/Time-Slots/blob/master/images/screen_4.png)


## Usage

#### Controller

```swift

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

```

## Requirements

### Build

Xcode Version 11.3 (11C29), iOS 13.2.0 SDK

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each this release can be found in the [CHANGELOG](CHANGELOG.mdown). 

