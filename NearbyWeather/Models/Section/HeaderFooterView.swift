//
//  HeaderFooterView.swift
//  NearbyWeather
//
//  Created by orik on 18/08/2019.
//  Copyright © 2019 orik. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: HeaderFooterView, section: Int)
}

class HeaderFooterView: UITableViewHeaderFooterView {

    var delegate: ExpandableHeaderViewDelegate?
    var section: Int?
    
    func setup(withTitle title: String, size: CGFloat, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.delegate = delegate
        self.section = section
        self.textLabel?.font = UIFont(name: "Helvetica", size: size)
        self.textLabel?.text = title
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
            textLabel?.textColor = .white
            contentView.backgroundColor = .gray
        }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gesterRecognizer: UITapGestureRecognizer) {
        let cell = gesterRecognizer.view as! HeaderFooterView
        delegate?.toggleSection(header: self, section: cell.section!)
    }
}


