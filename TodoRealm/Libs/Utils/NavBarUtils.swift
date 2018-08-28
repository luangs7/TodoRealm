//
//  NavBarUtils.swift
//  Farmula-iOS
//
//  Created by Luan Silva on 19/01/17.
//  Copyright © 2017 55Apps. All rights reserved.
//

import UIKit


class NavBarUtils {
    
    //MARK: - Get
    static public func get(viewController: UIViewController) -> UINavigationBar? {
        guard let navigationController = viewController.navigationController else {
            return nil
        }
        
        return navigationController.navigationBar
    }
    
    //MARK: - Information
    static public func getHeight(viewController: UIViewController) -> CGFloat {
        guard let navigationBar = get(viewController: viewController) else {
            return 0.0
        }
        
        NavBarUtils.show(viewController: viewController)
        
        let height = navigationBar.frame.height
        return height
    }
    
    //MARK: - Show/Hide
    
    /**
     *  Método para mostrar a UINavigationBar no UIViewController passado.
     *
     *  - parameter viewController O UIViewController em que se deseja mostrar a navigation bar.
     *
     */
    static public func show(viewController: UIViewController) {
        guard let navigationBar = get(viewController: viewController) else {
            return
        }
        
        navigationBar.isHidden = false
    }
    
    static public func hide(viewController: UIViewController) {
        guard let navigationBar = get(viewController: viewController) else {
            return
        }
        
        navigationBar.isHidden = true
    }
    
    static public func hideBorder(viewController: UIViewController) {
        guard let navigationBar = get(viewController: viewController) else {
            return
        }
        
        navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationBar.shadowImage = UIImage()
    }
    
    //MARK: - Layout
    static public func adjust(height: CGFloat, forViewController viewController: UIViewController) {
        let bounds = viewController.navigationController!.navigationBar.bounds
        viewController.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
    }
    
    
    static public func setTitleVerticalPosition(value: CGFloat, viewController: UIViewController) {
        guard let navigationBar = get(viewController: viewController) else {
            return
        }
        navigationBar.setTitleVerticalPositionAdjustment(value, for: .default)
    }
    
    static public func setTransparent(viewController: UIViewController) {
        guard let navigationBar = get(viewController: viewController) else {
            return
        }
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
//        viewController.navigationController?.view.backgroundColor = .clear
    }
    
    static public func setWhite(viewController: UIViewController) {
        guard let navigationBar = get(viewController: viewController) else {
            return
        }
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
    }
    
    static public func setTranslucent(viewController: UIViewController) {
        guard let navigationBar = get(viewController: viewController) else {
            return
        }
        navigationBar.isTranslucent = true
        navigationBar.isOpaque = false
    }
    
    static public func setOpaque(viewController: UIViewController) {
        guard let navigationBar = get(viewController: viewController) else {
            return
        }
        navigationBar.isTranslucent = false
        navigationBar.isOpaque = true
    }
    
    static public func setTitle(title: String, forViewController viewController: UIViewController) {
        viewController.navigationItem.title = title
    }
    
    static public func setTitleColor(color: UIColor, andFont font: UIFont = UIFont.systemFont(ofSize: 17.0), forViewController viewController: UIViewController) {
        guard let navigationBar = get(viewController: viewController) else {
            return
        }
        
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font]
    }
    
    static public func setTitleAttributes(titleAttributes: [NSAttributedStringKey: AnyObject], forViewController viewController: UIViewController) {
        guard let navigationBar = get(viewController: viewController) else {
            return
        }
        
        navigationBar.titleTextAttributes = titleAttributes
    }
    
    /**
     Altera a cor dos navigation items e bar buttons da navigation bar.
     
     - parameter color: Cor desejada.
     - parameter viewController: O view controller em que se deseja alterar a tintColor da navigation bar.
     */
    static public func setTintColor(color: UIColor, forViewController viewController: UIViewController) {
        guard let navigationBar = get(viewController: viewController) else {
            return
        }
        navigationBar.tintColor = color
    }
    
    /**
     Altera a cor de fundo da navigation bar.
     
     - parameter color: Cor desejada.
     - parameter viewController: O view controller em que se deseja alterar a barTintColor da navigation bar.
     */
    static public func setBackgroundColor(color: UIColor, forViewController viewController: UIViewController) {
        guard let navigationBar = get(viewController: viewController) else {
            return
        }
        
        navigationBar.barTintColor = color
        navigationBar.isTranslucent = false
    }
    
    static public func setBackgroundColor(colors: [UIColor], forViewController viewController: UIViewController) {
        guard let navigationBar = get(viewController: viewController) else {
            return
        }
        
        navigationBar.setGradientBackgroundNav(colors: colors)
        navigationBar.isTranslucent = false
    }
    
    //MARK: - Back Button
    static public func setBackBarButtonWithTitle(title: String, forViewController viewController: UIViewController) {
        let backButton = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backButton
    }
    
    static public func setBackBarButtonWithImage(image: UIImage, forViewController viewController: UIViewController) {
        guard let navigationBar = get(viewController: viewController) else {
            return
        }
        
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationBar.backIndicatorImage = image.withRenderingMode(UIImageRenderingMode.alwaysOriginal).withAlignmentRectInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        navigationBar.backIndicatorTransitionMaskImage = image.withRenderingMode(UIImageRenderingMode.alwaysOriginal).withAlignmentRectInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    }
    
    //MARK: - Custom Push
    static public func setRightBarCustomButton(buttonItem: UIBarButtonItem?, withTarget target: UIViewController) {  
        if let buttonItem = buttonItem {
            target.navigationItem.rightBarButtonItem = buttonItem
        }
    }
    
    //MARK: - Close Modal
    static public func setLeftBarCustomButton(buttonItem: UIBarButtonItem?, withTarget target: UIViewController) {
        if let buttonItem = buttonItem {
            target.navigationItem.leftBarButtonItem = buttonItem
        }
    }
    
    //MARK: - Left Button
    static public func setLeftBarButton(object: AnyObject?, withTarget target: UIViewController, andAction action: Selector) {
        var leftButton : UIBarButtonItem?
        
        if let title = object as? String {
            leftButton = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        } else if let image = object as? UIImage {
            leftButton = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: target, action: action)
        }
        
        if let leftButton = leftButton {
            target.navigationItem.leftBarButtonItem = leftButton
        }
    }
    
    static public func setLeftSystemButton(systemItem: UIBarButtonSystemItem, onTarget target: UIViewController, andAction action: Selector) {
        let leftButton = UIBarButtonItem(barButtonSystemItem: systemItem, target: target, action: action)
        target.navigationItem.leftBarButtonItem = leftButton
    }
    
    static public func setLeftImage(image: UIImage?, onViewController viewController: UIViewController) {
        guard let image = image else {
            return
        }
        
        let leftButton = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        leftButton.isEnabled = false
        
        viewController.navigationItem.leftBarButtonItem = leftButton
    }
    /*
     _ = NavBarButtonItem(withImageName: "button-nav-calltoaction-default", andTitle: "Atualizar", target: self, andAction: #selector(updateAddress))
    */
    
    //MARK: - Right Button
    static func setRightBarButton(barButton: UIBarButtonItem, withTarget target: UIViewController) {
        target.navigationItem.rightBarButtonItem = barButton
    }
    
    static func setRightBarButtons(barButtons: [UIBarButtonItem], withTarget target: UIViewController) {
        target.navigationItem.rightBarButtonItems = barButtons
    }
    
    static func setLeftBarButton(barButton: UIBarButtonItem, withTarget target: UIViewController) {
        target.navigationItem.leftBarButtonItem = barButton
    }
    
    static public func setRightBarButton(object: AnyObject?, withTarget target: UIViewController, andAction action: Selector) {
        var rightButton: UIBarButtonItem?
        if let title = object as? String {
            rightButton = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        } else if let image = object as? UIImage {
            rightButton = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: target, action: action)
        }
        
        if let rightButton = rightButton {
            target.navigationItem.rightBarButtonItem = rightButton
        }
    }
    
    static public func setRightSystemButton(systemItem: UIBarButtonSystemItem, onTarget target: UIViewController, andAction action: Selector) {
        let rightButton = UIBarButtonItem(barButtonSystemItem: systemItem, target: target, action: action)
        target.navigationItem.rightBarButtonItem = rightButton
    }
    
    static public func setRightImage(image: UIImage?, onViewController viewController: UIViewController) {
        guard let image = image else {
            return
        }
        
        let rightButton = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        rightButton.isEnabled = false
        
        viewController.navigationItem.rightBarButtonItem = rightButton
    }
    
    //MARK: - Center View Item
    
    static public func setTitleView(image: UIImage?, onTarget target: UIViewController) {
        guard let image = image else {
            return
        }
        target.navigationItem.titleView = UIImageView(image: image.withRenderingMode(.alwaysOriginal))
    }
}








