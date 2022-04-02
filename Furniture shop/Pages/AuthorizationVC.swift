//
//  AuthorizationVC.swift
//  Furniture shop
//
//  Created by Shaxzod Azamatjonov on 14/03/22.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import Firebase
import AuthenticationServices
import CryptoKit

class AuthorizationVC: UIViewController{
    fileprivate var currentNonce: String?
    let backgroundImage = UIImageView()
    let titleLabel = UILabel()
    let nameTextField = UITextField()
    let phoneNumberTextField = UITextField()
    let getAuthorization = UIButton()
    let signInGoogle = UIButton()
    let appleButton = ASAuthorizationAppleIDButton(type: .continue, style: .black)
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
}

extension AuthorizationVC{
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
        view.addSubview(nameTextField)
        view.addSubview(phoneNumberTextField)
        nameTextField.placeholder = "name"
        nameTextField.layer.cornerRadius = 20
        nameTextField.layer.borderWidth = 2
        nameTextField.setLeftPaddingPoints(20)
        phoneNumberTextField.backgroundColor = .white.withAlphaComponent(0.8)
        nameTextField.layer.borderColor = UIColor.textColor.cgColor
        nameTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(60)
        }
        phoneNumberTextField.placeholder = "+998"
        phoneNumberTextField.keyboardType = .phonePad
        phoneNumberTextField.setLeftPaddingPoints(20)
        phoneNumberTextField.backgroundColor = .white.withAlphaComponent(0.8)
        phoneNumberTextField.layer.cornerRadius = 20
        phoneNumberTextField.layer.borderWidth = 2
        phoneNumberTextField.layer.borderColor = UIColor.textColor.cgColor
        phoneNumberTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.height.equalTo(60)
        }
        view.addSubview(getAuthorization)
        getAuthorization.setTitle("Get code", for: .normal)
        getAuthorization.layer.cornerRadius = 20
        getAuthorization.backgroundColor = .textColor
        getAuthorization.layer.masksToBounds = false
        getAuthorization.layer.shadowColor = UIColor.black.cgColor
        getAuthorization.layer.shadowOpacity = 0.8
        getAuthorization.layer.shadowRadius = 5
        getAuthorization.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        getAuthorization.addTarget(self, action: #selector(getCode), for: .touchUpInside)
        getAuthorization.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        view.addSubview(signInGoogle)
        signInGoogle.setTitle("sign in with Google", for: .normal)
        signInGoogle.setImage(UIImage(named: "google"), for: .normal)
        signInGoogle.centerTextAndImage(spacing: 20)
        signInGoogle.layer.cornerRadius = 20
        signInGoogle.backgroundColor = .textColor
        signInGoogle.layer.masksToBounds = false
        signInGoogle.layer.shadowColor = UIColor.black.cgColor
        signInGoogle.layer.shadowOpacity = 0.8
        signInGoogle.layer.shadowRadius = 5
        signInGoogle.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        signInGoogle.snp.makeConstraints { make in
            make.top.equalTo(getAuthorization.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        view.addSubview(appleButton)
        appleButton.cornerRadius = 17
        appleButton.addTarget(self, action: #selector(signInApple), for: .touchUpInside)
        appleButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(signInGoogle.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
}
// MARK: ButtonsAction
extension AuthorizationVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
    
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    @objc func signInApple() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if (error != nil) {
                    print(error?.localizedDescription)
                    return
                }
                let vc = UINavigationController(rootViewController: TabBarController())
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .flipHorizontal
                self.present(vc, animated: false, completion: nil)
                UserDefaultsManager.shared.saveAuth(reg: true)
            }
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
    @objc func getCode(){
        guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            phoneNumberTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print("error " + error.localizedDescription)
                return
            }
            let vc =  CodeConfirmationVC()
            vc.verificationId = verificationID
            self.navigationController?.pushViewController(vc, animated: true)

            if self.nameTextField.text?.isEmpty ?? true {
                UserDefaultsManager.shared.saveName(name: "User")
             } else {
                 UserDefaultsManager.shared.saveName(name: self.nameTextField.text)
             }
            UserDefaultsManager.shared.saveAddress(address: self.phoneNumberTextField.text)
        }
    }
    @objc func signInWithGoogle(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            if let error = error {
                print("Error: \(error)")
            }
            
            let emailAddress = user?.profile?.email
            let givenName = user?.profile?.givenName
            let profilePicture = user?.profile?.imageURL(withDimension: 320)
            
            UserDefaultsManager.shared.saveName(name: givenName)
            UserDefaultsManager.shared.saveAddress(address: emailAddress)
            UserDefaultsManager.shared.saveProfileImage(address: profilePicture)
            
            guard let authentication = user?.authentication, let idToken = authentication.idToken else {return}
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { result, err in
                if let error = error {
                    print("authentication error \(error.localizedDescription)")
                }
                let vc = UINavigationController(rootViewController: TabBarController())
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .flipHorizontal
                self.present(vc, animated: false, completion: nil)
                UserDefaultsManager.shared.saveAuth(reg: true)
            }
        }
        
    }
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}
