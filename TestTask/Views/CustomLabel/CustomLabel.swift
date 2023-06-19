//
//  CustomLabel.swift
//  TestTask
//
//  Created by Денис Набиуллин on 07.06.2023.
//

import UIKit.UILabel

class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .black
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
