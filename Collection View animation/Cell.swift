//
//  Cell.swift
//  Collection View animation
//
//  Created by Levente Vig on 2020. 02. 07..
//  Copyright © 2020. levivig. All rights reserved.
//

import UIKit

protocol CellBindable {
    var isOpen: Bool { get }
}

class Cell: UICollectionViewCell {
    
    // MARK: - Private properties -
    
    private var imageView: UIImageView!
    
    private var isOpen: Bool = false {
        didSet {
            rotateImage()
        }
    }
    
    // MARK: - Initialization -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        initImageView()
    }
    
    private func initImageView() {
        imageView = UIImageView()
        imageView.image = UIImage(named: "arrow")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func bind(model: CellBindable) {
        isOpen = model.isOpen
    }
    
    func rotateImage() {
        UIView.animate(withDuration: 0.6) {
            if self.isOpen {
                self.imageView.transform = CGAffineTransform(rotationAngle: 90)
            } else {
                self.imageView.transform = .identity
            }
            self.imageView.setNeedsLayout()
            self.imageView.layoutIfNeeded()
        }
    }
}
