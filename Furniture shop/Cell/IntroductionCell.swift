//
//  IntroductionCell.swift
//  Furniture shop
//
//  Created by Shaxzod Azamatjonov on 14/03/22.
//

import UIKit

class IntroductionCell: UICollectionViewCell {
    let imageView = UIImageView()
    static let identifier = "introductionCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initViews(){
        self.addSubview(imageView)
        imageView.image = UIImage(named: "first")
        imageView.contentMode = .redraw
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func setItems(item: IntroductionModel){
        imageView.image = UIImage(named: item.imagesName)
    }
}
