//
//  LoginView.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/18.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit
import Flea

class LoginView: UIView {

    let titleLabel = { () -> UILabel in
        let label = UILabel()
        label.text = "Welcome to Flea"
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(20)
        label.textColor = FleaPalette.DarkGray
        
        return label
    }()
    
    let nameTextField = { () -> UITextField in
        let field = UITextField()
        field.textColor = FleaPalette.DarkGray
        field.placeholder = "Username"
        field.textAlignment = .Center
        field.font = UIFont.systemFontOfSize(15)
        
        return field
    }()
    
    let passwordField = { () -> UITextField in
        let field = UITextField()
        field.textColor = FleaPalette.DarkGray
        field.secureTextEntry = true
        field.placeholder = "Password"
        field.textAlignment = .Center
        field.font = UIFont.systemFontOfSize(15)
        
        return field
    }()
    
    let confirmButton = { () -> UIButton in
        let button = UIButton(type: .System)
        button.backgroundColor = FleaPalette.Blue
        button.tintColor = UIColor.whiteColor()
        button.setTitle("Sign In", forState: .Normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(nameTextField)
        addSubview(passwordField)
        addSubview(confirmButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin = CGSize(width: 10, height: 5)
        titleLabel.frame = CGRect(x: margin.width, y: 30, width: bounds.width - margin.width * 2, height: 44)
        nameTextField.frame = CGRect(x: margin.width, y: titleLabel.frame.maxY + margin.height, width: bounds.width - margin.width * 2, height: 44)
        passwordField.frame = CGRect(x: margin.width, y: nameTextField.frame.maxY + margin.height, width: bounds.width - margin.width * 2, height: 44)
        confirmButton.frame = CGRect(x: 0, y: bounds.height - 50, width: bounds.width, height: 50)
    }
}
