//
//  SquareView.swift
//  TicTacToe1
//
//  Created by Karapet on 07.05.22.
//

import UIKit

class SquareView: UIView {
    var label: UILabel!
    var button: UIButton!
    var onButtonSelection: (() -> Void)?
    var isValueSet: Bool = false
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        initLabel()
        initButton()
        constructHierarchy()
        activateConstraints()
        
        button.addTarget(
            self, action: #selector(buttonPressed),
            for: .touchUpInside
        )
    }
    
    @objc func buttonPressed() {
        onButtonSelection?()
    }
    
    func set(value: String) {
        guard isValueSet else {
            label.text = value
            isValueSet = true
            return
        }
        isValueSet = true
    }
    
    func removeData() {
        isValueSet = false
        label.text = ""
    }
}

extension SquareView {
    private func initLabel() {
        label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 30, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initButton() {
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func constructHierarchy() {
        addSubview(label)
        addSubview(button)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

