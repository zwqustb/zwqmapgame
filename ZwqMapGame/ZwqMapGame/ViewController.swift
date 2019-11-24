//
//  ViewController.swift
//  ZwqMapGame
//
//  Created by boeDev on 2019/11/17.
//  Copyright © 2019 zwq. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 130
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.borderColor = UIColor.red.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout.init()
        let sideWidth = KScreenHeight/10
        layout.itemSize = CGSize.init(width: sideWidth, height: sideWidth)
        layout.minimumInteritemSpacing =  0
        layout.minimumLineSpacing = 0
        layout.sectionInset = .zero
        layout.scrollDirection = .horizontal
        let pContentView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        pContentView.delegate = self
        pContentView.dataSource = self
        pContentView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        self.view.addSubview(pContentView)
        //for test
        // Do any additional setup after loading the view.
    }


}

