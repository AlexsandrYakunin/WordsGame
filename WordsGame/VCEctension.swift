//
//  VCEctension.swift
//  WordsGame
//
//  Created by Александр on 30.10.2021.
//

import UIKit

extension UIViewController {
    
    func addTapToDismiss() {
        
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    // Функция скрывающая клавиатуру
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showInfoAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK, понял", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
