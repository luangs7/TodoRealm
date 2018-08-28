//
//  BaseViewController.swift
//  ClickServicesApp
//
//  Created by Luan Silva on 29/11/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit

class BaseViewController: LibBaseViewController {
    
    //MARK: Variables
    internal var didLayoutSubviews: Bool = false
    internal var session = Session.shared
    internal var screenHeight: CGFloat {get{return UIScreen.main.bounds.height}}
    internal var screenWidth: CGFloat {get{return UIScreen.main.bounds.width}}
    typealias onSuccess =  (_ success: Bool) -> Void
    internal var isNavBlack:Bool = false

    var rootNavigation: UINavigationController {
        get{
            return appDelegate.getRootNavigation()
        }
    }
    
    deinit {
        deinitStackControl()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initStackControl()
        setupMenuNavBarButton()
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isNavBlack{
            setupNavBarBlack()
        }else{
            setupNavBar()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
}

//MARK: Flow
extension BaseViewController {
    
    func startHomeFlow() {
        
    }
    
    //MARK: Navbar
    internal func setupNavBar(viewController: BaseViewController! = nil, sideMenu: Bool! = false) {
        
        var vc = self
        if viewController != nil {
            vc = viewController
        }

        let color = StatusBarUtils.hexStringToUIColor(hex: "#ffffff")
//        var colors = [UIColor]()
//        colors.append(StatusBarUtils.hexStringToUIColor(hex: "#21959f"))
//        colors.append(StatusBarUtils.hexStringToUIColor(hex: "#2dbdf4"))
        
//        NavBarUtils.hideBorder(viewController: vc)
        NavBarUtils.setBackgroundColor(color: UIColor.white, forViewController: vc)
        
        NavBarUtils.setTintColor(color: .black, forViewController: vc)
        NavBarUtils.setTitleColor(color: .black, forViewController: vc)
        NavBarUtils.setBackBarButtonWithTitle(title: "", forViewController: vc)
    }
    
    //MARK: Navbar
    internal func setupNavBarBlack(viewController: BaseViewController! = nil, sideMenu: Bool! = false) {
        
        var vc = self
        if viewController != nil {
            vc = viewController
        }
        
        
        NavBarUtils.setBackgroundColor(color: UIColor.black, forViewController: vc)
        NavBarUtils.setTitleColor(color: UIColor.white, forViewController: vc)
        NavBarUtils.setBackBarButtonWithImage(image: UIImage(named:"arrow_back_white")!, forViewController: vc)
//        NavBarUtils.setBackBarButtonWithTitle(title: "", forViewController: vc)

    }
    
    
    internal func setupMenuNavBarButton() {
    
        guard let navigationController = navigationController else {
            return
        }
        
        guard navigationController.viewControllers.count == 1 else {
            return
        }

        //set icon for menu drawer
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "drawer_icon"), style: .plain, target: self, action: #selector(SSASideMenu.presentLeftMenuViewController))
    }
}

//MARK: Getters
extension BaseViewController {
    func textField(_ textFieldNamed: String) -> UITextField! {
        if let topVC = navigationController?.viewControllers.last {
            let allTextFields_ = allTextFields(fromView: topVC.view)
            for textField in allTextFields_ {
                if textField.accessibilityIdentifier == textFieldNamed {
                    return textField
                }
            }
        }
        return UITextField()
    }
    
    func delegateTextFields(_ viewController: BaseViewController) {
        let allTextFields_ = allTextFields(fromView: viewController.view)
        for textField in allTextFields_ {
            textField.tintColor = StatusBarUtils.hexStringToUIColor(hex: "#000000")
            textField.delegate = viewController as? UITextFieldDelegate
        }
    }
    
    func setTextFieldsPlaceholderWhite(_ viewController: BaseViewController) {
        let allTextFields_ = allTextFields(fromView: viewController.view)
        for textField in allTextFields_ {
            textField.setPlaceholderWhite()
        }
    }
    
    func allTextFields(fromView view: UIView)-> [UITextField] {
        return view.subviews.flatMap { (view) -> [UITextField]? in
            if view is UITextField {
                return [(view as! UITextField)]
            } else {
                return allTextFields(fromView: view)
            }}.flatMap({$0})
    }
}
