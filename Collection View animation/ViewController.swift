//
//  ViewController.swift
//  Collection View animation
//
//  Created by Levente Vig on 2020. 02. 07..
//  Copyright © 2020. levivig. All rights reserved.
//

import UIKit

class Model: CellBindable {
    
    private var _isOpen: Bool = false
    
    var isOpen: Bool {
        get {
            return _isOpen
        }
        set {
            _isOpen = newValue
        }
    }
}

class ViewController: UIViewController {
    
    // MARK: - Private properties -
    
    private var items = Array(repeating: Model(), count: 20)
    
    private var collectionView: UICollectionView!
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Initialization -
    
    private func setup() {
        initCollectionView()
        collectionView.reloadData()
    }
    
    private func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 50)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.setNeedsUpdateConstraints()
        collectionView.layoutIfNeeded()
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        let model = items[indexPath.row]
        cell.bind(model: model)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = items[indexPath.row]
        model.isOpen.toggle()
        
        if let cell = collectionView.cellForItem(at: indexPath) as? Cell {
            cell.bind(model: model)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 50)
    }
}
