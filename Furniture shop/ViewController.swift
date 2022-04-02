//
//  ViewController.swift
//  Furniture shop
//
//  Created by Shaxzod Azamatjonov on 14/03/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let data = MockData.introductionData
    let skipButton = UIButton()
    weak var collectionView: UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    private func initViews(){
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .horizontal
        l.minimumInteritemSpacing = 0
        l.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: l)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(IntroductionCell.self, forCellWithReuseIdentifier: IntroductionCell.identifier)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(skipButton)
        skipButton.isHidden = true
        skipButton.setTitle("Register now", for: .normal)
        skipButton.setTitleColor(.blue.withAlphaComponent(0.7), for: .normal)
        skipButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
        skipButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
        skipButton.addTarget(self, action: #selector(authorizationButton), for: .touchUpInside)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IntroductionCell.identifier, for: indexPath) as! IntroductionCell
        cell.setItems(item: data[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == 2 {
            skipButton.isHidden = false
        }
        else{
            skipButton.isHidden = true
        }
    }
    @objc func authorizationButton(){
        let vc = UINavigationController(rootViewController: AuthorizationVC())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
}

