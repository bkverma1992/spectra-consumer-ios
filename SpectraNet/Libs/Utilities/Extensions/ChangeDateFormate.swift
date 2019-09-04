//
//  ChangeDateFormate.swift
//  SpectraNet
//
//  Created by Yugasalabs-28 on 29/07/2019.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func setChangeDateFormate(previousDateStr: String) -> String {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = DateFormats.orderDateFormat
        let showDate = inputFormatter.date(from: previousDateStr)
        inputFormatter.dateFormat = DateFormats.dateFormatOnly
        let resultString = inputFormatter.string(from: showDate!)
        return resultString
    }
    
    func selectFromDate(datePicker: UIDatePicker, hiddenTranspView: UIView, hiddenDoneBTNView: UIView) {
        
    
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        print(formattedDate)
        datePicker.date = date
        let date1 = Calendar.current.date(byAdding: .year, value: -5, to: Date())
        
        let calendar = Calendar.current
        var minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        minDateComponent.day = calendar.component(.day, from: date1!)
        minDateComponent.month = calendar.component(.month, from: date1!)
        minDateComponent.year = calendar.component(.year, from: date1!)
        
        let minDate = calendar.date(from: minDateComponent)
        print(minDate as Any)
        
        var maxDateComponent = calendar.dateComponents([.day,.month,.year], from: date)
        maxDateComponent.day = calendar.component(.day, from: date)
        maxDateComponent.month = calendar.component(.month, from: date)
        maxDateComponent.year = calendar.component(.year, from: date)
        
        let maxDate = calendar.date(from: maxDateComponent)
        print(maxDate as Any)
        datePicker.minimumDate = minDate! as Date
        datePicker.maximumDate =  maxDate! as Date
        
        hiddenTranspView.isHidden = false
        hiddenDoneBTNView.isHidden = false
        datePicker.isHidden = false
        datePicker.backgroundColor = UIColor.white
    }
    
    func selectToDate(datePicker: UIDatePicker, getFromStringDate: String, hiddenTranspView: UIView, hiddenDoneBTNView: UIView) {
        
        let format = DateFormatter()
        format.dateFormat = DateFormats.orderCurrentDateFormatOutPut
        let date1 = format.date(from: getFromStringDate)
        let formattedDate = format.string(from: date1!)
        print(formattedDate)
        //  let date2 = Calendar.current.date(byAdding: .year, value: -1, to: Date())
        let calendar = Calendar.current
        var minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        minDateComponent.day = calendar.component(.day, from: date1!)
        minDateComponent.month = calendar.component(.month, from: date1!)
        minDateComponent.year = calendar.component(.year, from: date1!)
        
        let minDate = calendar.date(from: minDateComponent)
        print(minDate as Any)
        print(getFromStringDate)
        
        
        var yearValue = Float()
        var getCurrentDate1 = String()
         getCurrentDate1 = getCurrentDate(withFormate: DateFormats.orderCurrentDateFormatOutPut)
        
        if getCurrentDate1 == getFromStringDate
        {
            yearValue = 0
        }
        else
        {
            yearValue = 1
        }
        
        
        var maxDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        maxDateComponent.day = calendar.component(.day, from: date1!)
        maxDateComponent.month = calendar.component(.month, from: date1!)
        maxDateComponent.year = calendar.component(.year, from: date1!)+Int(yearValue)
        
        let maxDate = calendar.date(from: maxDateComponent)
        print(maxDate as Any)
        
        datePicker.minimumDate = minDate! as Date
        datePicker.maximumDate =  maxDate! as Date
        
        hiddenTranspView.isHidden = false
        hiddenDoneBTNView.isHidden = false
        datePicker.isHidden = false
        datePicker.backgroundColor = UIColor.white
    }
    
    func getCurrentDate(withFormate: String)-> String
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = withFormate
        let result = formatter.string(from: date)

        return result
    }
    
    func getLastNumberOfMonthPreviousDate(numberOfMonth: Int) -> String
    {
        let previousMonth = Calendar.current.date(byAdding: .month, value: Int(numberOfMonth), to: Date())
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: previousMonth!) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = DateFormats.orderCurrentDateFormatOutPut
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
    }
    
    func setInvoiceListDateFormate(previousDateStr: String, withPreviousDateFormte: String, replaeWithFormate: String) -> String {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = withPreviousDateFormte
        let showDate = inputFormatter.date(from: previousDateStr)
        inputFormatter.dateFormat = replaeWithFormate //DateFormats.orderDateFormat
        let resultString = inputFormatter.string(from: showDate!)
        return resultString
    }
    func setBackgroundColrAccordingToClic(selectedBGColor : UIColor,withSelectedBTN: UIButton, withUnselectedButton: UIButton,withUnselected2BTN: UIButton, unselectedBGColor: UIColor,withSelectedBool: Bool, unselectBool: Bool, withselecedLine: UILabel, unselect1: UILabel, unselect2: UILabel)
    {
        withSelectedBTN.setTitleColor(selectedBGColor, for: .normal)
        withUnselectedButton.setTitleColor(unselectedBGColor, for: .normal)
        withUnselected2BTN.setTitleColor(unselectedBGColor, for: .normal)
        withselecedLine.isHidden = withSelectedBool
        unselect1.isHidden = unselectBool
        unselect2.isHidden = unselectBool
    }
  
}
