//
//  UIViewController+Utils.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit

extension UIViewController {

    func dismissKeyboardOn(target: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        target.isUserInteractionEnabled = true
        target.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard(gestureRecognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    @objc func showAlertWithOkAction(
        title: String,
        message: String,
        addCancel: Bool = false,
        completion: ((UIAlertAction) -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        var handler: ((UIAlertAction) -> Void)?

        if let completion = completion {
            handler = completion
        }

        let action  = UIAlertAction(
            title: "OK",
            style: .default,
            handler: handler)

        alert.addAction(action)

        if addCancel {
            let cancelAction  = UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil)

            alert.addAction(cancelAction)
        }

        self.present(alert, animated: true, completion: nil)
    }

    func showErrorAlertFor(errorMessage: String) {
        showAlertWithOkAction(
            title: "ERROR",
            message: errorMessage
        )
    }
}
