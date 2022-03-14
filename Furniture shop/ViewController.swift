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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    private func initViews(){
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .horizontal
        l.minimumInteritemSpacing = 0
        l.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: l)
        view.addSubview(collectionView)
    }
}

