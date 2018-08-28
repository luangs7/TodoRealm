//
//  ProjctExtensions.swift
//  ClickServicesApp
//
//  Created by Luan Silva Gehlen Bornholdt on 15/12/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyShadowWith(radius: CGFloat,shadowOpacity:Float) {
        layer.masksToBounds = false
        layer.shadowRadius = radius
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = shadowOpacity
    }

    func applyShadowWith(radius: CGFloat) {
        layer.masksToBounds = false
        layer.shadowRadius = radius
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 1.0
    }
    
    func applyDefaultShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        layer.shadowOpacity = 0.5
        
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 1.0
    }
    
    func applyRoundedBorderWithColor(color:CGColor) {
//        layer.borderWidth = 1
//        layer.borderColor = color
        layer.cornerRadius = frame.height/2
    }
    
    func applyOrangeRoundedBorder() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.colorWithRed(red: 242, green: 146, blue: 33, andAlpha: 1.0).cgColor
        layer.cornerRadius = frame.height/2
    }
    
    func round() {
        let radiusFactor = self.bounds.size.width/2
        self.layer.cornerRadius = radiusFactor
    }
    
    func round(roundValue:CGFloat) {
        let radiusFactor = roundValue
        self.layer.cornerRadius = radiusFactor
    }
    
    func activityStart() {
        let actv = UIActivityIndicatorView(activityIndicatorStyle: .white)
        actv.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        self.insertSubview(actv, at: 1)
        actv.startAnimating()
    }
    
    func activityStop() {
        for view in self.subviews {
            if let _ = view as? UIActivityIndicatorView {
                view.removeFromSuperview()
            }
        }
    }
}

extension UITextField {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setPlaceholderWhite() {
        self.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
    }
    
    func setPadding(_ value: CGFloat) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.size.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.size.height))
        self.rightView = rightPaddingView
        self.rightViewMode = .always
    }
    
    func setSearchIcon() {
        let width: CGFloat = 15
        let height: CGFloat = 15
        
        let searchImage = UIImage(named: "search_icon")
        let searchImageView = UIImageView(image: searchImage)
        searchImageView.frame = CGRect(x: center.x - frame.width/1.99, y: center.y/2 - 7.5, width: width, height: height)
        searchImageView.contentMode = .scaleAspectFit
        searchImageView.backgroundColor = .white
        searchImageView.alpha = 0.2
        addSubview(searchImageView)
        setPadding(40)
    }
}

extension Double{
    func toReal()->String{
        let formatter = NumberFormatter()
        formatter.currencySymbol = "\(formatter.currencySymbol!)"
        formatter.numberStyle = .currency
        //        formatter.locale = NSLocale.current
        formatter.locale = Locale(identifier: "pt_BR")
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension String {
    func toMoneyValue() -> String {
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol!
       
        var value = self.unmask()
        value = value.replacingOccurrences(of: currencySymbol, with: "")
        return value.insertString(string: ",", atIndex: value.length - 2)
    }
    
    func isValidName() -> Bool {
        let nameArray = self.split(separator: " ")
        if nameArray.count >= 2 {
            return true
        }
        return false
    }
}

extension UIStackView {
    func setStarFor(rateValue value: Int, bigSize: Bool = false) {
        for view in self.arrangedSubviews {
            if let button = view as? UIButton {
                if button.tag <= value {
                    let imageName = bigSize ? "star_icon_yellow_big" : "star_icon_yellow"
                    let yellowStar = UIImage(named: imageName)!
                    button.setImage(yellowStar, for: .normal)
                } else {
                    let imageName = bigSize ? "star_icon_grey_big" : "star_icon_grey"
                    let greyStar = UIImage(named: imageName)!
                    button.setImage(greyStar, for: .normal)
                }
            }
            
            if let imageView = view as? UIImageView {
                if imageView.tag <= value {
                    let imageName = bigSize ? "star_icon_yellow_big" : "star_icon_yellow"
                    let yellowStar = UIImage(named: imageName)!
                    imageView.image = yellowStar
                    imageView.contentMode = .scaleAspectFit
                }else {
                    let imageName = bigSize ? "star_icon_grey_big" : "star_icon_grey"
                    let greyStar = UIImage(named: imageName)!
                    imageView.image = greyStar
                    imageView.contentMode = .scaleAspectFit
                }
            }
        }
    }
}
