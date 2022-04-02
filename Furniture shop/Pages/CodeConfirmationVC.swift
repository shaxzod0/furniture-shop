//
//  CodeConfirmationVC.swift
//  Furniture shop
//
//  Created by Shaxzod Azamatjonov on 14/03/22.
//

import UIKit

class CodeConfirmationVC: UIViewController, UITextFieldDelegate {
    let backgroundImage = UIImageView()
    let titleLabel = UILabel()
    var verificationId: String?
    let informationMessage = UILabel()
    var indicator = 0
    var textFieldBank: [UITextField] = []
    let confirmButton = UIButton()
    let stackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
}

extension CodeConfirmationVC{
    private func initViews(){
        view.addSubview(backgroundImage)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(titleLabel)
        titleLabel.text = "Baraka \nMebel"
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .textColor
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Snell Roundhand", size:60)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
        }
        view.addSubview(informationMessage)
        informationMessage.text = "Please enter the code which you get"
        informationMessage.font = .systemFont(ofSize: 24, weight: .bold)
        informationMessage.textColor = .textColor
        informationMessage.numberOfLines = 0
        informationMessage.textAlignment = .center
        informationMessage.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(informationMessage.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(80)
        }
        for index in 0..<6 {
            let tf = UITextField()
            tf.backgroundColor = .white
            tf.font = .systemFont(ofSize: 34, weight: .bold)
            tf.layer.cornerRadius = 6
            tf.placeholder = "_"
            tf.textAlignment = .center
            tf.delegate = self
            tf.tag = index
            stackView.addArrangedSubview(tf)
            textFieldBank.append(tf)
        }
        view.addSubview(confirmButton)
        confirmButton.setTitle("Confirm code", for: .normal)
        confirmButton.layer.cornerRadius = 20
        confirmButton.backgroundColor = .textColor
        confirmButton.layer.masksToBounds = false
        confirmButton.layer.shadowColor = UIColor.black.cgColor
        confirmButton.layer.shadowOpacity = 0.8
        confirmButton.layer.shadowRadius = 5
        confirmButton.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        confirmButton.addTarget(self, action: #selector(confirmCode), for: .touchUpInside)
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    @objc func confirmCode(){
        let vc = TabBarController()
        navigationController?.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(vc, animated: false)
    }
}
