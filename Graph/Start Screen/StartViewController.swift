//
//  StartViewController.swift
//  Graph
//
//  Created by sarin on 03/03/2019.
//  Copyright © 2019 nikitasarin. All rights reserved.
//

import UIKit
import MBProgressHUD

class StartViewController: UIViewController {

    @IBOutlet private var numberTextField: UITextField!
    private let viewmodel = StartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        recognizer.minimumNumberOfTouches = 1
        view.addGestureRecognizer(recognizer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        numberTextField.text = ""
        hideKeyBoard()
    }

    @objc private func hideKeyBoard(){
        view.endEditing(true)
    }
    
    @IBAction func runButtonPressed(_ sender: Any) {
        let validation = viewmodel.validate(numberTextField.text ?? "")
        guard validation.success else {
            handle(error: GraphError.invalidPointsCount)
            return
        }
        MBProgressHUD.showAdded(to: view, animated: true)
        viewmodel.downloadPoints(count: validation.value) { (error) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            guard error == nil else{
                self.handle(error: error!)
                return
            }
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "PointsTableViewController") as? PointsTableViewController,
                let viewmodel = self.viewmodel.viewmodelForTableViewController(){
                viewController.viewmodel = viewmodel
                self.show(viewController, sender: self)
            }
        }
    }
    
    private func handle(error: Error){
        var handledError: GraphError
        if let graphError = error as? GraphError,
            GraphError.allCases.contains(graphError){
            handledError = graphError
        } else{
            handledError = GraphError.another
        }
        showAlert(title: NSLocalizedString("Ошибка", comment: ""),
                  message: handledError.localizedDescription)
    }
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: NSLocalizedString("Ок", comment: ""),
                                     style: .default,
                                     handler: nil)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
