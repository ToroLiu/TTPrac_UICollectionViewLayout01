//
//  ViewController.swift
//  DEMO
//
//  Created by aecho on 2016/5/31.
//  Copyright © 2016年 aecho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct Group {
        var title: String
        var list: [Item]
    }
    
    struct Item {
        var imageName: String
        var from: String
        var end: String

    }
    
    private var itemList: [Group] = [
        Group(title: "05/01", list: [
            Item(imageName: "1.jpg", from: "10:55:33", end: "10:55:45"),
            Item(imageName: "2.jpg", from: "11:11:33", end: "11:56:33"),
            Item(imageName: "3.jpg", from: "12:55:33", end: "10:55:45"),
            Item(imageName: "4.jpg", from: "13:11:33", end: "11:56:33"),
            Item(imageName: "5.jpg", from: "14:55:33", end: "10:55:45"),
            Item(imageName: "6.jpg", from: "15:11:33", end: "11:56:33"),
            Item(imageName: "7.jpg", from: "16:55:33", end: "10:55:45"),
            ]),
        Group(title: "05/02", list: [
            Item(imageName: "8.jpg", from: "11:11:33", end: "11:56:33"),
            Item(imageName: "9.jpg", from: "10:55:33", end: "10:55:45"),
            Item(imageName: "10.jpg", from: "11:11:33", end: "11:56:33"),
            Item(imageName: "11.jpg", from: "12:55:33", end: "10:55:45"),
            Item(imageName: "12.jpg", from: "13:11:33", end: "11:56:33"),
            Item(imageName: "13.jpg", from: "14:55:33", end: "10:55:45"),
            ]),
        Group(title: "05/03", list: [
            Item(imageName: "1.jpg", from: "10:55:33", end: "10:55:45"),
            Item(imageName: "2.jpg", from: "11:11:33", end: "11:56:33"),
            Item(imageName: "3.jpg", from: "12:55:33", end: "10:55:45"),
            ]),
        Group(title: "05/04", list: [
            Item(imageName: "8.jpg", from: "11:11:33", end: "11:56:33"),
            Item(imageName: "13.jpg", from: "14:55:33", end: "10:55:45"),
            ]),
        Group(title: "05/05", list: [
            Item(imageName: "1.jpg", from: "10:55:33", end: "10:55:45"),
            Item(imageName: "2.jpg", from: "11:11:33", end: "11:56:33"),
            Item(imageName: "3.jpg", from: "12:55:33", end: "10:55:45"),
            ]),
        Group(title: "05/06", list: [
            Item(imageName: "1.jpg", from: "11:11:33", end: "11:56:33"),
            ]),
        Group(title: "05/07", list: [
            Item(imageName: "4.jpg", from: "11:11:33", end: "11:56:33"),
            ]),
        Group(title: "05/08", list: [
            Item(imageName: "10.jpg", from: "11:11:33", end: "11:56:33"),
            ]),
        Group(title: "05/09", list: [
            Item(imageName: "1.jpg", from: "10:55:33", end: "10:55:45"),
            Item(imageName: "2.jpg", from: "11:11:33", end: "11:56:33"),
            Item(imageName: "3.jpg", from: "12:55:33", end: "10:55:45"),
            Item(imageName: "4.jpg", from: "13:11:33", end: "11:56:33"),
            Item(imageName: "5.jpg", from: "14:55:33", end: "10:55:45"),
            Item(imageName: "6.jpg", from: "15:11:33", end: "11:56:33"),
            Item(imageName: "7.jpg", from: "16:55:33", end: "10:55:45"),
            Item(imageName: "8.jpg", from: "11:11:33", end: "11:56:33"),
            Item(imageName: "9.jpg", from: "10:55:33", end: "10:55:45"),
            Item(imageName: "10.jpg", from: "11:11:33", end: "11:56:33"),
            Item(imageName: "11.jpg", from: "12:55:33", end: "10:55:45"),
            Item(imageName: "12.jpg", from: "13:11:33", end: "11:56:33"),
            Item(imageName: "13.jpg", from: "14:55:33", end: "10:55:45"),
            ]),
        
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "TTImageCell", bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "cell")
        
        let secNib = UINib.init(nibName: "TTImageSection", bundle: nil)
        collectionView.registerNib(secNib, forSupplementaryViewOfKind: "section", withReuseIdentifier: "section")
        
        NSLog("viewDidLoad")
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return itemList.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = itemList[section]
        return group.list.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        NSLog("for cell @ \(indexPath)")
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TTImageCell
        
        let group = itemList[indexPath.section]
        let item = group.list[indexPath.row]
        
        let image = UIImage(named: item.imageName)!
        cell.configure(image: image, from: item.from, to: item.end)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        NSLog("for supplementary element @ \(indexPath)")
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "section", forIndexPath: indexPath) as! TTImageSection
        
        let group = itemList[indexPath.section]
        view.configure(title: group.title)
        
        return view
    }
}

