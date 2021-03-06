//
//  LibBaseViewController.swift
//  Farmula-iOS
//
//  Created by Luan Silva on 24/01/17.
//  Copyright © 2017 55Apps. All rights reserved.
//

import UIKit

///Classe com diversos métodos para auxiliar no desenvolvimento de view controllers.
open class LibBaseViewController: UIViewController, CustomTaskDelegate {
    
    //App Delegate shared instance
    internal var appDelegate = AppDelegate.shared()
    
    ///Variável booleana que indica se o view controller deve cancelar automaticamente as tasks ao passar pelo viewWillDisappear.
    internal var cancelTasksOnViewWillDisappear: Bool = true
    
    //keyboard handle use
    internal var scrollViewBase: UIScrollView?
    internal var activeTextField: UITextField?
    

    ///Variável booleana que indica se o view controller possui conexão com a Internet.
    fileprivate var isOnline: Bool = false
    
    //MARK: - View Lifecycle
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupQueue()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\n############# !!MERMORY WARNING!! #############")
        print("\n############## !!DO SOMETHING!! ##############")
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        KeyboardUtils.hide(view)
        
        if cancelTasksOnViewWillDisappear {
            cancelTasks()
        }
    }
    
    //MARK: - Alert
    /**
     Mostra um `UIAlertView` com o título e mensagem passados.
     
     - parameters:
     - title: Título do alerta.
     - message: Mensagem de corpo do alerta. Caso não seja definido, o valor padrão é *nil*.
     */
    public func alert(_ title: String? = "Ninky", withMessage message: String) {
        AlertUtils.alert(title, message: message, onViewController: self)
    }
    public func alert(_ title: String? = "Ninky", withMessage message: String,withHandler handler: @escaping ((_ action: UIAlertAction) -> Void)) {
        AlertUtils.alert(title, message: message, onViewController: self, withHandler:handler)

    }
    
    
    ///Add Tap Recognizer
    internal func addTapRecognizerToSubview() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        
        view.addGestureRecognizer(tap)
    }
    
    internal func getCorrectSubviews() -> [UIView] {
        var correctSubviews : [UIView] = []
        
        for view in view.subviews {
            if (view is UIImageView) {
                continue
            }
            correctSubviews.append(view)
        }
        
        return correctSubviews
    }
    
    internal func hideKeyb() {
        KeyboardUtils.hide(view)
    }
}


//MARK: Stack Controll
extension LibBaseViewController {
    /**
     This function controls the heap
        */
    internal func initStackControl() {
        print("\n\n#### INIT VC ####")
        let stackValue = appDelegate.getStackValue() + 1
        appDelegate.setSatckValue(stackValue: stackValue)
        print("-Stack Control- \n Viewcontrollers in Stack: \(stackValue)\n")
    }
    
    internal func deinitStackControl() {
        let stackValue = appDelegate.getStackValue()
        print("\n#### STARTED DEINIT VC ####")
        print("atual stack: \(stackValue)")
        if let app = UIApplication.shared.delegate as? AppDelegate, let _ = app.window {
            if let viewControllers = app.window!.rootViewController?.childViewControllers{
                for vc in viewControllers {
                    
                    print("\n #### VC IN WINDOW ####")
                    print(vc.description)
                    for c in vc.childViewControllers {
                        print("\n #### CHILD IN VC ####")
                        print(c.description)
                    }
                }
            }
        }
        appDelegate.setSatckValue(stackValue: stackValue - 1)
        print("\n\ndeinit\n-Stack Control- \n Viewcontroller: \(self.debugDescription) \n final stack: \(stackValue - 1)")
    }
}



//MARK: Segues
extension LibBaseViewController {
    internal func presentModal(viewController: UIViewController, withCloseButton useCloseButton: Bool? = true) {

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .custom
        navigationController.navigationBar.isHidden = false
        navigationController.modalPresentationCapturesStatusBarAppearance = true
//        navigationController.navigationBar.backgroundColor = StatusBarUtils.hexStringToUIColor(hex: "#2dbdf4")
       
        viewController.view.setNeedsLayout()
        NavBarUtils.setTintColor(color: UIColor.red, forViewController: viewController)
        NavBarUtils.setBackgroundColor(color: UIColor.black, forViewController: viewController)

        if useCloseButton! {
            NavBarUtils.setLeftBarCustomButton(buttonItem: NavBarButtonItem(withType: .navCloseWhite), withTarget: viewController)
        }
        
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
    internal func dismissViewController() {
        self.navigationController?.popViewController(animated: false)
    }
    
    internal func pushViewController(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    internal func pushViewControllers(viewControllers: [UIViewController],animated: Bool) {
        self.navigationController?.setViewControllers(viewControllers, animated: animated)
    }
    
    internal func pushViewControllerWithCompletion(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.navigationController?.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    internal func popViewControllerWithCompletion(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.navigationController?.popViewController(animated: animated)
        CATransaction.commit()
    }
    
    
    
    internal func presentCrossDissolve(viewController: UIViewController) {
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .custom
        navigationController.modalTransitionStyle = .crossDissolve
        
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
    //actions dissmiss
    internal func closeActionDismiss() {
        if let currentVC = getCurrentViewController() {
            _ = currentVC.dismiss(animated: true, completion: nil)
        }
    }
    
    internal func getCurrentViewController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    
    internal func removeAt(index:Int){
        self.navigationController?.viewControllers.remove(at: index)
    }
    
    internal func removeAll(){
        self.navigationController!.viewControllers.removeAll()
    }
    
    internal func removeLast(last:Int){
        if last == 0 {
            self.navigationController!.viewControllers.removeLast()
        }else{
            self.navigationController!.viewControllers.removeLast(last)
        }
    }
    
    internal func removeAndPush(last:Int,viewController:UIViewController){
        var vcArray = self.navigationController?.viewControllers
        if last == 0 {
            vcArray!.removeLast()
        }else{
            vcArray!.removeLast(last)
        }
        vcArray!.append(viewController)
        self.navigationController?.setViewControllers(vcArray!, animated: true)

    }
}



//MARK: Keyboard Handle
extension LibBaseViewController {
    
    /**
     Mostra o teclado e associa as ações do mesmo ao elemento passado.
     
     - parameter view: Uma view que conforma o protocolo `UIKeyInput`.
     */
    open func showKeyboard(_ view: UIKeyInput?) {
        KeyboardUtils.show(view)
    }
    
    /**
     Esconde o teclado.
     */
    @objc open func hideKeyboard() {
        KeyboardUtils.hide(view)
    }
    
    /**
     Registra as notifições de abertura e fechamento do teclado.
     
     As ações de abrir e fechar o teclado estarão associadas aos métodos **keyboardDidShow** e **keyboardDidHide**, respectivamente.
     */
    internal func registerKeyboardNotificationsWith(scrollView: UIScrollView!) {

        scrollViewBase = scrollView
        registerNotification(NSNotification.Name.UIKeyboardWillShow.rawValue, withSelector: #selector(keyboardDidShow(_:)))
        registerNotification(NSNotification.Name.UIKeyboardWillHide.rawValue, withSelector: #selector(keyboardDidHide(_:)))
        
        addTapRecognizerToSubview()
    }
    
    open func unRegisterKeyboardNotifications() {
        unregisterNotification(NSNotification.Name.UIKeyboardWillShow.rawValue)
        unregisterNotification(NSNotification.Name.UIKeyboardWillHide.rawValue)
        
    }
    
    
    
    open func addBlur(blurView: UIView){
        
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        myActivityIndicator.startAnimating()
        
        blurView.frame = UIScreen.main.bounds
        blurView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blurView.layer.zPosition = CGFloat(MAXFLOAT)
        myActivityIndicator.center = blurView.center
        blurView.addSubview(myActivityIndicator)
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        if let window = UIApplication.shared.keyWindow{
            window.addSubview(blurView)
        }
    }
    
    open func addBlurDialog(viewToBlur:UIView){
        viewToBlur.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        viewToBlur.isHidden = false
    }
    
    open func removeBlurDialog(viewToBlur: UIView) {
        viewToBlur.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        viewToBlur.isHidden = true
    }
    
    open func removeBlur(blurView: UIView) {
        if let window = UIApplication.shared.keyWindow{        
            if window.subviews.contains(blurView) {
                if UIApplication.shared.isIgnoringInteractionEvents {
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
                blurView.removeFromSuperview()
            }
        }
    }
    
    /**
     Método disparado ao abrir o teclado. Por padrão, não há implementação neste método.
     
     - important: Este método não será chamado caso o método **registerKeyboardNotifications** não tenha sido chamado anteriormente.
     Os view controllers que desejarem obter informações do teclado devem sobrescrever este método.
     
     - parameter notification: A notificação com as informações do teclado como tempo de duração da animação, tamanho, etc.
     */
    @objc internal func keyboardDidShow(_ notification: Foundation.Notification) {
        keyBoardShow()
        guard let userInfo = (notification as NSNotification).userInfo else {
            return
        }
        
        guard let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if let _scrollView = scrollViewBase {
            //rect
            let keyboardRect = view.convert(keyboardSize, from: nil)
            //pega a posição do scroll
            let _scrollViewRect: CGRect = view.convert(_scrollView.frame, from: _scrollView.superview)
            //acerta o tamanho exato necessário
            let hiddenScrollViewRect: CGFloat = _scrollViewRect.intersection(keyboardRect).height + 10.0
            
            if _scrollViewRect.intersects(keyboardRect){
                let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: hiddenScrollViewRect, right: 0.0)
                _scrollView.contentInset = contentInsets
                _scrollView.scrollIndicatorInsets = contentInsets
            }
        }
    }
    
    //override to use
    internal func keyBoardShow() {}
    
    /**
     Método disparado ao fechar o teclado. Por padrão, não há implementação neste método.
     
     - important: Este método não será chamado caso o método **registerKeyboardNotifications** não tenha sido chamado anteriormente.
     Os view controllers que desejarem obter informações do teclado devem sobrescrever este método.
     
     - parameter notification: A notificação com as informações do teclado como tempo de duração da animação, tamanho, etc.
     */
    @objc internal func keyboardDidHide(_ notification: Notification) {
        keyBoardHide()
        if let _scrollView = scrollViewBase {
            //reset scrollview
            let contentInsets = UIEdgeInsets.zero
            _scrollView.contentInset = contentInsets
            _scrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    //override to use
    internal func keyBoardHide() {}
}
