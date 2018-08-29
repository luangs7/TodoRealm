//
//  ChatViewController.swift
//  TodoRealm
//
//  Created by Retina on 8/29/18.
//  Copyright © 2018 Retina. All rights reserved.
//

import UIKit

class ChatViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageBox: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerKeyboarNotification()
        addTapRecognizerToSubview()
        messageBox.applyShadowWith(radius: 3)
    }

    private func registerKeyboarNotification(){
        registerNotification(NSNotification.Name.UIKeyboardWillShow.rawValue, withSelector: #selector(self.handleKeyboard(_:)))
        registerNotification(NSNotification.Name.UIKeyboardWillHide.rawValue, withSelector: #selector(self.handleKeyboard(_:)))
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterKeyboarNotification()
    }
    
    private func unregisterKeyboarNotification() {
        unregisterNotification(NSNotification.Name.UIKeyboardWillShow.rawValue)
        unregisterNotification(NSNotification.Name.UIKeyboardWillHide.rawValue)
    }
    
    @objc func keyboardWillShow(_ notification:NSNotification){
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        {
            
            //keyboardFrame.height is getting diff values when open and close
            self.view.frame.origin.y -= 250

        }
    }
    
    @objc func keyboardWillHide(_ notification:NSNotification){
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        {
            self.view.frame.origin.y += 250
        }
    }
    
    @objc func handleKeyboard(_ notification:NSNotification){
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            isKeyboardShowing ? keyboardWillShow(notification) : keyboardWillHide(notification)
        }

    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
