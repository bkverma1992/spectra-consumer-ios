//
//  UIView+GradientColor.swift
//  SpectraNet
//
//  Created by Bhoopendra on 7/12/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func setCornerRadiusView(radius: Float, color: UIColor, view: UIView)
    {
        view.layer.cornerRadius = CGFloat(radius)
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = color.cgColor
    }
    
    func setButtonBackgroundImage(button: UIButton)
    {
        let image = UIImage(named: "frwd") as UIImage?
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.white
    }
    
    func setGradientBackground(view: UIView)
    {
        let colorTop = UIColor(red: 243.0/255.0, green: 111.0/255.0, blue: 105.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 246.0/255.0, green: 141.0/255.0, blue: 110.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorBottom, colorTop]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

extension UIViewController
{
    func setBelowlineColor(below1stTabLine: UILabel, withColor: UIColor, below2ndTabLine: UILabel, withColor2: UIColor,btn1stTab: UIButton, with1stBtnTabColor: UIColor, btn2ndTab: UIButton, with2ndBtnTabColor: UIColor, setstatus: String, toLabel: UILabel) {
        below1stTabLine.backgroundColor = withColor
        below2ndTabLine.backgroundColor = withColor2
        btn1stTab.setTitleColor(with1stBtnTabColor, for:UIControl.State.normal)
        btn2ndTab.setTitleColor(with2ndBtnTabColor, for:UIControl.State.normal)
        toLabel.text = setstatus
    }
}
extension UIColor {
    static let bgColors = UIColor(red:255/255, green:108/255 ,blue:102/255, alpha:1.00)
    static let viewBackgroundFullOpack = UIColor(red:246/255, green:122/255 ,blue:133/255, alpha:1.00)
    static let viewBackgroundHalfOpack = UIColor(red:246/255, green:122/255 ,blue:133/255, alpha:0.9)
    static let cornerBGFullOpack = UIColor(red: 229.0/255.0, green: 105.0/255.0, blue: 97.0/255.0, alpha: 1.0)
    static let bgHalfOpackWithWhite = UIColor(red:255/255, green:255/255 ,blue:255/255, alpha:0.7)
    static let bgDataFillColor = UIColor(red: 224/255.0, green: 98/255.0, blue: 96/255.0, alpha: 1)


}

