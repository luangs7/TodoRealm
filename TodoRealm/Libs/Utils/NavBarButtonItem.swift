//
//  NavBarButtonItem.swift
//  Farmula-iOS
//
//  Created by Luan Silva on 19/01/17.
//  Copyright © 2017 55Apps. All rights reserved.
//

import UIKit

///aumentar conforme opções
//TODO: NavButtonType
public enum Type {
    case navCloseWhite, navCloseBlack, navBackButton, none
}

class NavBarButtonItem: UIBarButtonItem {
    
   private let button = UIButton()
    
    deinit {
        print("deinit NavBarButtonItem")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init(withType type: Type!){
        super.init()
        self.setupBarButton(type: type)
    }
    
    required init(withImageName imgName: String!, title: String!, target: UIViewController, andAction action: Selector){
        super.init()
        
            customView = createNavButtonItemWithImageBackground(withImageName: imgName, andTitle: title, withTarget: target, andAction: action)
        
    }
    
    //switch case conforme opções
    func setupBarButton(type: Type){
        switch type {
        case .navCloseWhite:
            customView = createNavWhiteCloseButtonItem()
        case .navCloseBlack:
            customView = createNavBlackCloseButtonItem()
        case .navBackButton:
            customView = createNavBackButtomItem()
        case .none:
            break
        }
    }
    
    //MARK: - Creates
    private func createNavBackButtomItem() -> UIButton {
        button.setImage(UIImage(named: "button-nav-back-black-default"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        return button
    }
        
    private func createNavBlackCloseButtonItem() -> UIButton {
        button.setImage(UIImage(named: "button-nav-close-black-default"), for: .normal)
        button.addTarget(self, action: #selector(NavBarButtonItem.closeActionDismiss), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return button
    }
    
    private func createNavWhiteCloseButtonItem() -> UIButton {
        button.setImage(UIImage(named: "close_button_white"), for: .normal)
        button.addTarget(self, action: #selector(NavBarButtonItem.closeActionDismiss), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return button
    }
    
    private func createNavButtonItemWithImageBackground(withImageName imgName: String!, andTitle title: String!, withTarget: UIViewController, andAction action: Selector) -> UIButton{
        
        button.setBackgroundImage(UIImage(named: imgName), for: .normal)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(withTarget, action: action, for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        
        return button
    }
    
    //actions
    @objc func closeActionDismiss() {
        if let currentVC = getCurrentViewController() {
            _ = currentVC.dismiss(animated: true, completion: nil)
        }
    }

    private func getCurrentViewController() -> UIViewController? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let currentViewController = appDelegate.window?.rootViewController?.presentedViewController
        
        return currentViewController
    }
}
