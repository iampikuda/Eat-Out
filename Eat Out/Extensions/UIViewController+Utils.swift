//
//  UIViewController+Utils.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit

extension UIViewController {
    @objc func showAlertWithOkAction(
        title: String,
        message: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            )
        )

        self.present(alert, animated: true, completion: nil)
    }

    func showErrorAlertFor(errorMessage: String) {
        showAlertWithOkAction(
            title: "ERROR",
            message: errorMessage
        )
    }
}
