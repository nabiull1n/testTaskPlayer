//
//  CustomButton.swift
//  TestTask
//
//  Created by Денис Набиуллин on 07.06.2023.
//

import UIKit.UIButton

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String){
        super.init(frame: .zero)
        setImage(UIImage(systemName: title), for: .normal)
        transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
