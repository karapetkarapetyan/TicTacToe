//
//  ViewController.swift
//  TicTacToe1
//
//  Created by Karapet on 07.05.22.
//

import UIKit

class ViewController: UIViewController {
    var resetButton: UIButton!
    var titleLabel: UILabel!
    var mainStackView: UIStackView!
    var squareViews: [SquareView] = []
    var gameArray: [[String]] = []
    
    var isXState: Bool = true
    var isNewGameState: Bool = false {
        didSet {
            if isNewGameState {
                squareViews.forEach({ $0.removeData() })
                isNewGameState = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTitleLabel()
        initStackView()
        initresetButton()
        
        constructHierarchy()
        activateConstraints()
        
        createSquareGrid(size: 1...3)
        
        resetButton.addTarget(self, action: #selector(resetButtonPressed),
            for: .touchUpInside
        )
    }
    
    func createSquareGrid(size: ClosedRange<Int>) {
        for i in size {
            let stackView = createHorizontalStackView()
            mainStackView.addArrangedSubview(stackView)
            
            gameArray.append([])
            for j in size {
                let squareView = SquareView()
                gameArray[i-1].append("")
                
                squareView.onButtonSelection = {
                    if self.isXState {
                        self.gameArray[i-1][j-1] = "X"
                        squareView.set(value: "X")
                    } else {
                        self.gameArray[i-1][j-1] = "O"
                        squareView.set(value: "O")
                    }
                    self.isXState.toggle()
                }
                
                let height = (Int(view.frame.width) - 50 - (size.upperBound - 1)*5)/size.upperBound
                NSLayoutConstraint.activate([
                    squareView.heightAnchor.constraint(equalToConstant: CGFloat(height))
                ])
                
                squareViews.append(squareView)
                stackView.addArrangedSubview(squareView)
            }
        }
    }
    
    func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }
    
    @objc func resetButtonPressed() {
        isNewGameState = true
    }
}
// MARK: - Layout
extension ViewController {
    private func initresetButton() {
        resetButton = UIButton(type: .system)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.blue, for: .normal)
        resetButton.layer.cornerRadius = 12
        resetButton.backgroundColor = .red
        resetButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 35, weight: .heavy)
        titleLabel.textColor = .red
        titleLabel.text = "TicTacToe"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initStackView() {
        mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 5
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.backgroundColor = .blue
    }
    
    private func constructHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(mainStackView)
        view.addSubview(resetButton)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            mainStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 45),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            resetButton.heightAnchor.constraint(equalToConstant: 60),
            resetButton.widthAnchor.constraint(equalToConstant: 250),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        ])
    }
}


