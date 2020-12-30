//
//  HomeCollectionViewCell.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit
import SnapKit

final class HomeCollectionViewCell: UICollectionViewCell {
    private let mainView = UIView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: ImageName.defaultLogo.rawValue)
        return imageView
    }()
   
    private let heartImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: ImageName.heart.rawValue)?.withRenderingMode(.alwaysTemplate)
        imageView.isHidden = true
        imageView.tintColor = .primary
        return imageView
    }()
    
    var restuarant: Restuarant? {
        didSet {
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        
    }
    
    private func bindData() {
        
    }
}
