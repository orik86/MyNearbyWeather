//
//  ViewControler+Animate.swift
//  NearbyWeather
//
//  Created by orik on 16/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import UIKit

extension ViewController {
    
    func animateHello() {
        
        let date = Date()
        let formatDate = DateFormatter()
        formatDate.dateFormat = "HH"
        
        let formatedDate = formatDate.string(from: date)
        switch Int(formatedDate)! {
            case 5...11:     animation(message: "Доброе утро")
            case 12...17:     animation(message: "Добрый день")
            case 18...23:     animation(message: "Добрый вечер")
            default: animation(message: "Доброй ночи")
        }
    }
    func animation(message: String){
        
  
        helloLabel.textColor = .black
        helloLabel.text = message
        UIView.animate(withDuration: 5, animations: {
            self.helloLabel.alpha = CGFloat(0)

        })
        helloLabel.isEnabled = false
        
    }
}
