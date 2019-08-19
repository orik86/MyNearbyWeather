//
//  ViewController+Allert.swift
//  NearbyWeather
//
//  Created by orik on 18/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import UIKit

extension ViewController {

    func allert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
