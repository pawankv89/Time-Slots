//
//  BookingTimeSlots.swift
//  PickMeUp
//
//  Created by Pawan kumar on 13/03/20.
//  Copyright © 2020 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

//delegate you should use
protocol BookingTimeSlotsDelegate: class {
    func bookingTimeSlotsSubmitButton(date: String)
}

class BookingTimeSlots: UIView {
    
    public weak var delegate: BookingTimeSlotsDelegate?
    
    @IBOutlet weak var overlayImageView: UIImageView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var contantView: UIView!
    
    @IBOutlet weak var bookingTimeSlotsContainerView: UIView!
    
    @IBOutlet weak var pleaseSelectYourTimeSlotsLabel: UILabel!
    @IBOutlet weak var yourPickUpTimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
   
     //Segment Button
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var segmentButton1View: UIView!
    @IBOutlet weak var segmentButton2View: UIView!
    @IBOutlet weak var segmentButton1DayLabel: UILabel!
    @IBOutlet weak var segmentButton1DateLabel: UILabel!
    @IBOutlet weak var segmentButton2DayLabel: UILabel!
    @IBOutlet weak var segmentButton2DateLabel: UILabel!
    @IBOutlet weak var segmentButton1: UIButton!
    @IBOutlet weak var segmentButton2: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var youWillGetYourOrderLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
 
    var timeSlotslist = [String]()
    
    var previousDate : Date?
    var slotsAvailable = ""
    var todayDate: Date!
    var tomorrowDate: Date!

    var slotsAvailableIndex: Int = 0
    var segmentButtonIndex: Int = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        
        Bundle.main.loadNibNamed("BookingTimeSlots", owner: self, options: nil)
        view.frame = self.frame
        addSubview(view)
        
        self.contantView.setCardView()
       
        self.bookingTimeSlotsContainerView.backgroundColor = .white
        self.bookingTimeSlotsContainerView.setCardView()
        
        self.borderOfViewWith(view: segmentView, border: 1, radius: segmentView.bounds.height/2, color: .white)

        self.segmentButtonTap(index: 0)
        
        conifgCollectionView()
        
        let overlayPath = UIBezierPath.init(rect: view.bounds)
        overlayPath.usesEvenOddFillRule = true
        let fillLayer = CAShapeLayer()
        fillLayer.path = overlayPath.cgPath
        fillLayer.fillRule = CAShapeLayerFillRule.evenOdd
        fillLayer.fillColor = UIColor.black.withAlphaComponent(0.5).cgColor
        overlayImageView.layer.addSublayer(fillLayer)
        
    }
    
    func updateSegmentTime(index: Int, todayDate: Date, tomorrowDate: Date) -> Void {
    
        //Segment 1
        let todayTime = self.getDateTime(date: todayDate)
        print("Time \(todayTime.time), Day \(todayTime.day), Date \(todayTime.date)")
        
        //Set Time
        self.segmentButton1DayLabel.text = todayTime.day
        self.segmentButton1DateLabel.text = todayTime.date
        
        //Segment 2
        let tomorrowTime = self.getDateTime(date: tomorrowDate)
        print("Time \(tomorrowTime.time), Day \(tomorrowTime.day), Date \(tomorrowTime.date)")
        
        //Set Time
        self.segmentButton2DayLabel.text = tomorrowTime.day
        self.segmentButton2DateLabel.text = tomorrowTime.date
        
        let timeSlots = self.timeSlotslist[self.slotsAvailableIndex]
           
        if index == 0 {
            
            if self.slotsAvailableIndex == 0 {
                self.timeLabel.text = todayTime.day + " " + todayTime.date + " " + "(Now)"
            } else {
                self.timeLabel.text = todayTime.day + " " + todayTime.date + " " + "(\(timeSlots))"
            }
        }
        if index == 1 {
          self.timeLabel.text = tomorrowTime.day + " " + tomorrowTime.date + " " + "(\(timeSlots))"
        }
    }
    
    func configurationTimeSlots(index: Int) -> Void {
        
        //Remove All Object
        if ( self.timeSlotslist.count > 0 ) { self.timeSlotslist.removeAll() }
        self.timeSlotslist = []
        
        let todayDate = Date()
        let tomorrowDate = Date.tomorrow
        let tomorrowAfterDate = Date.tomorrowAfter
        
        var date1 = todayDate
        var date2 = tomorrowDate
        
        if index == 0 {
           
             date1 = todayDate
             date2 = tomorrowDate
        }
        if index == 1 {
            
            date1 = tomorrowDate
            date2 = tomorrowAfterDate
        }

              let formatter2 = DateFormatter()
              formatter2.dateFormat = "hh:mma"
              
              date1 = self.correctTimeOfDate(date: date1)
              var string1 = formatter2.string(from: date1)
           
              var i = 1
              while true {
                 
                let date = date1.addingTimeInterval(TimeInterval(i*30*60))
                let string = formatter2.string(from: date)

                if date >= date2 {
                  
                    date1 = self.lastTimeOfDate(date: date)
                    let string = formatter2.string(from: date1)
                    self.timeSlotslist.append((string1 + " - " + string).lowercased())
                      break;
                  }

                  i += 1
               self.timeSlotslist.append((string1 + " - " + string).lowercased())
                  string1 = string
              }
              
        print(self.timeSlotslist)
        
        self.todayDate = todayDate
        self.tomorrowDate = tomorrowDate
        
        //Update Segment Button
        self.updateSegmentTime(index: segmentButtonIndex, todayDate: todayDate, tomorrowDate: tomorrowDate)
        
        self.collectionView.reloadData()
    
    }

    func segmentButtonTap(index: Int) -> () {
        
        if index == 0 {
            
            segmentButtonIndex = index
            slotsAvailableIndex = 0
            segmentButton1View.backgroundColor = UIColor.purple
            segmentButton1DayLabel.textColor = .white
            segmentButton1DateLabel.textColor = .white
            
            segmentButton2View.backgroundColor = UIColor.lightGray
            segmentButton2DayLabel.textColor = .black
            segmentButton2DateLabel.textColor = .black
            
             configurationTimeSlots(index: index)
        }
        if index == 1 {
            
            segmentButtonIndex = index
            slotsAvailableIndex = 0
            segmentButton1View.backgroundColor = UIColor.lightGray
            segmentButton1DayLabel.textColor = .black
            segmentButton1DateLabel.textColor = .black
            
            segmentButton2View.backgroundColor = UIColor.purple
            segmentButton2DayLabel.textColor = .white
            segmentButton2DateLabel.textColor = .white
            
            configurationTimeSlots(index: index)
        }
    
    }
    
    @IBAction func segmentButton1Tap(_ sender: UIButton)-> () {
         
        self.segmentButtonTap(index: 0)
    }
    @IBAction func segmentButton2Tap(_ sender: UIButton)-> () {
         
        self.segmentButtonTap(index: 1)
    }
    
    @IBAction func submitButtonTap(_ sender: UIButton)-> () {
        
        let timeSlots = self.timeSlotslist[self.slotsAvailableIndex]
        let arrayTimeSlots = timeSlots.components(separatedBy: " - ")
        
        let todayTime = self.getDateTime(date: self.todayDate)
        let tomorrowTime = self.getDateTime(date: self.tomorrowDate)
        
        if segmentButtonIndex == 0 {
            
            if self.slotsAvailableIndex == 0 {
                //Now
                
                DBManager.setValueForKey(key: DBManager.dbTimeSlotsDisplay, value: "Now")
                DBManager.setValueForKey(key: DBManager.dbTimeSlotsDay, value: todayTime.day)
            } else {
                DBManager.setValueForKey(key: DBManager.dbTimeSlotsDisplay, value: "\(todayTime.day)" + ", " + "\(arrayTimeSlots.last!)")
                DBManager.setValueForKey(key: DBManager.dbTimeSlotsDay, value: todayTime.day)
            }
            
            DBManager.setValueForKey(key: DBManager.dbTimeSlotsDate, value: todayTime.apidate)
        }
        if segmentButtonIndex == 1 {
            DBManager.setValueForKey(key: DBManager.dbTimeSlotsDisplay, value: "\(tomorrowTime.day)" + ", " + "\(arrayTimeSlots.last!)")
            DBManager.setValueForKey(key: DBManager.dbTimeSlotsDay, value: tomorrowTime.day)
            DBManager.setValueForKey(key: DBManager.dbTimeSlotsDate, value: tomorrowTime.apidate)
        }
        
        //Time Slots (Open-Close)
        DBManager.setValueForKey(key: DBManager.dbTimeSlotsOpen, value: "\(arrayTimeSlots.first!)")
        DBManager.setValueForKey(key: DBManager.dbTimeSlotsLastClose, value: "\(arrayTimeSlots.last!)")
        DBManager.setValueForKey(key: DBManager.dbTimeSlots, value: timeSlots)
        
        delegate?.bookingTimeSlotsSubmitButton(date: "Today Date / Tomorrow Date")
    }
}


//#MARK:- TableView DataSource & Delegate

extension BookingTimeSlots: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func conifgCollectionView() {
          
        let listCellNib = UINib(nibName: TimeCollectionCell.identifier, bundle: nil)
        self.collectionView.register(listCellNib, forCellWithReuseIdentifier: TimeCollectionCell.identifier)
               
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
                
        //FlowLayout for Managed Grid and List
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.vertical //.horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        
                
        //Reload List items
        self.collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.timeSlotslist.count > section {
        
            return self.timeSlotslist.count
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        //For List & For Grid ( 1 -> List & 2 -> Grid)
        let cellWidth: CGFloat = self.collectionView.frame.size.width / 3  - 10
        let cellheight: CGFloat = self.collectionView.frame.size.height / 1 - 6 //150
        //let cellheight: CGFloat = 50
        //let cellWidth: CGFloat = 150
        let cellSize = CGSize(width: cellWidth , height: cellheight)
        
        return cellSize
    }

   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionCell.identifier, for: indexPath as IndexPath) as! TimeCollectionCell
        
        let timeSlots = self.timeSlotslist[indexPath.row]
        
        let arrayTimeSlots = timeSlots.components(separatedBy: " - ")
      
        //Button Segment Index
        if segmentButtonIndex == 0 {
        
            //Did Select Item
            if (indexPath.row == 0) {
                
                cell.timeNowLabel.text = "Now"
                cell.time1Label.text = ""
                cell.timeToLabel.text = ""
                cell.time2Label.text = ""
            
            } else {
                
                cell.timeNowLabel.text = ""
                cell.time1Label.text = arrayTimeSlots.first
                cell.timeToLabel.text = "to"
                cell.time2Label.text = arrayTimeSlots.last
            }
            
        } else if segmentButtonIndex == 1 {
                   
            cell.timeNowLabel.text = ""
            cell.time1Label.text = arrayTimeSlots.first
            cell.timeToLabel.text = "to"
            cell.time2Label.text = arrayTimeSlots.last
        }
        
        //Did Select Item
        if (slotsAvailableIndex == indexPath.row) {
            cell.bgView.backgroundColor = UIColor.purple
            cell.timeNowLabel.textColor = UIColor.white
            cell.time1Label.textColor = UIColor.white
            cell.timeToLabel.textColor = UIColor.white
            cell.time2Label.textColor = UIColor.white
        } else {
            cell.bgView.backgroundColor = UIColor.white
            cell.timeNowLabel.textColor = UIColor.purple
            cell.time1Label.textColor = UIColor.purple
            cell.timeToLabel.textColor = UIColor.purple
            cell.time2Label.textColor = UIColor.purple
        }
        
        //Border
        self.circleOfViewWith(view: cell, border: 1, color: .lightGray)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let filter = self.timeSlotslist[indexPath.row]
        self.slotsAvailableIndex = indexPath.row
        self.collectionView.reloadData()
        
        //Update Segment Button
        self.updateSegmentTime(index: segmentButtonIndex, todayDate: self.todayDate, tomorrowDate: self.tomorrowDate)
        
        print("collectionView didSelectItemAt:- ", filter)

    }
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    static var tomorrowAfter:  Date { return Date().dayAfter2 }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var dayAfter2: Date {
           return Calendar.current.date(byAdding: .day, value: 2, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}

extension UIView {
    
    // MARK: - Border Of View With Border Color
    func borderOfViewWith(view: UIView, border: CGFloat, radius: CGFloat, color: UIColor) -> Void {

        view.layer.borderWidth = border //2
        view.layer.cornerRadius = radius //5
        view.layer.borderColor = color.cgColor //Red
        view.layer.masksToBounds = true
    }
    
    // MARK: - Circle Of View With Border Color
    func circleOfViewWith(view: UIView, border: CGFloat, color: UIColor) -> Void {

        view.layer.borderWidth = border //2
        view.layer.cornerRadius = view.bounds.height / 2
        view.layer.borderColor = color.cgColor //Red
        view.layer.masksToBounds = true
    }
    
    func setCardView(){
        layer.cornerRadius = 5.0
        layer.borderColor  =  UIColor.clear.cgColor
        layer.borderWidth = 5.0
        layer.shadowOpacity = 0.5
        layer.shadowColor =  UIColor.lightGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:5, height: 5)
        layer.masksToBounds = true
    }
    
    func getDateTime(date: Date) -> (time: String, day: String, date: String, apidate: String) {
          
          let timeFormatter = DateFormatter()
          timeFormatter.dateFormat = "hh:mma" //hh:mma ->05:09PM
                        
          let dayFormatter = DateFormatter()
          dayFormatter.dateFormat = "EEE" //EEEE -> Monday & EEE -> Mon
           
     //Display Date
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd MMM yyyy" //dd MMM yyyy -> 23 Mar 2020
     //API Date
         let apidateFormatter = DateFormatter()
         apidateFormatter.dateFormat = "yyyy-MM-dd" //yyyy-MM-dd -> 2020-03-18
                        
          let time_date = timeFormatter.string(from: date)
          let day_date = dayFormatter.string(from: date)
          let date_date = dateFormatter.string(from: date)
          let apidate_date = apidateFormatter.string(from: date)
     
          print("Time \(time_date), Day \(day_date), Date \(date_date), API Date \(apidate_date)")
          
          return ( time_date, day_date, date_date, apidate_date)
      }
     
    func lastTimeOfDate(date: Date) -> Date {
         
         let timeFormatter = DateFormatter()
         timeFormatter.dateFormat = "mm"
         let time_date = timeFormatter.string(from: date)
         let minnute: Int = Int(time_date)!
     
         if minnute == 00 {
             //Return old Date
             let date = date.addingTimeInterval(TimeInterval(-1*1*60))
             return date
         }
             
         return date
     }

    func correctTimeOfDate(date: Date) -> Date {
         
         let timeFormatter = DateFormatter()
         timeFormatter.dateFormat = "mm"
         let time_date = timeFormatter.string(from: date)
         var minnute: Int = Int(time_date)!
         
         if minnute == 30 || minnute == 00 {
             //Return old Date
             return date
             
         } else  if minnute < 30 && minnute > 0 {
             //Return old Date
              minnute = 30 - minnute
             let date1 = date.addingTimeInterval(TimeInterval(1*minnute*60))
             return date1
             
         } else  if minnute > 30 && minnute <= 59 {
             //Return old Date
             minnute = 60 - minnute
             let date2 = date.addingTimeInterval(TimeInterval(1*minnute*60))
             return date2
         }
             
         return date
     }
}
