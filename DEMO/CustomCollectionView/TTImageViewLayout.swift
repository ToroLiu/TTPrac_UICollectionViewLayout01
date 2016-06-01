//
//  TTImageViewLayout.swift
//  DEMO
//
//  Created by aecho on 2016/5/31.
//  Copyright © 2016年 aecho. All rights reserved.
//

import UIKit

class TTImageViewLayout: UICollectionViewLayout {

    var contentHeight: CGFloat = 0
    var contentWidth: CGFloat = 0
    
    var sectionWidth: CGFloat = 50
    var sectionHeight: CGFloat = 20
    var sectionZIndex: Int = 1024
    
    var cellWidth: CGFloat = 0
    var cellHeight: CGFloat = 140
    
    var cellGap: CGFloat = 2
    
    var cache = [UICollectionViewLayoutAttributes]()
    
    override func prepareLayout() {
        guard collectionView != nil else {
            return
        }

        contentWidth = CGRectGetWidth(collectionView!.bounds)
        cellWidth = contentWidth - sectionWidth
        
        var yOffset: CGFloat = 0
        var height: CGFloat = 0.0
        let sections = collectionView!.numberOfSections()
        for s in 0 ..< sections {
            height += sectionHeight
            
            let nums = collectionView!.numberOfItemsInSection(s)
            
            for c in 0 ..< nums {
                
                // Prepare cells
                let rt = CGRectMake(sectionWidth, yOffset, cellWidth, cellHeight)
                let indexPath = NSIndexPath(forItem: c, inSection: s)
                let attr = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attr.frame = rt
                cache.append(attr)
                
                height += (cellGap + cellHeight)
                yOffset += cellGap + cellHeight
            }
            yOffset += sectionHeight
        }
        
        // Decide Height
        contentHeight = (height - sectionHeight)
        
        NSLog("content Height: \(contentHeight) width: \(contentWidth)")
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(contentWidth, contentHeight)
    }

    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var sectionSet = [Int: UICollectionViewLayoutAttributes]()
        
        let currentOffset = collectionView!.contentOffset.y
        
        // Cell's attributes
        var result = [UICollectionViewLayoutAttributes]()
        for attr in cache {
            // If the cell is visible
            if (CGRectIntersectsRect(rect, attr.frame)) {
                
                // Insert visible cell's attributes
                result.append(attr)
                
                // For visible section attributes
                let section = attr.indexPath.section
                if (sectionSet.keys.contains(section) == false) {
                    sectionSet[section] = attr ///< The cell's attribute
                }
            }
        }
        
        // Section's attributes. Compute the rectangle for sections
        let secKeys = sectionSet.keys.sort { (first, second) -> Bool in
            return first > second
        }
        
        var nextSectionAttribute: UICollectionViewLayoutAttributes? = nil
        var secResult = [UICollectionViewLayoutAttributes]()
        
        for key in secKeys {
            let cellAttr = sectionSet[key]
            
            // 1. 對齊畫面最上方，stick在上面
            var sectionFrame = cellAttr!.frame
            sectionFrame.origin.x = 0
            sectionFrame.size = CGSizeMake(sectionWidth, sectionHeight)
            
            if (sectionFrame.origin.y < currentOffset) {
                sectionFrame.origin.y = currentOffset
            }
            
            // 2. 如果有next section的話，要考慮它的位置，調整目前的section位置
            if (nextSectionAttribute != nil) {
                let distY = CGRectGetMaxY(sectionFrame) - CGRectGetMinY(nextSectionAttribute!.frame)
                if (distY > 0) {
                    sectionFrame.origin.y -= distY ///< 使它們的間距為 0
                }
            }
            
            let secAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: "section", withIndexPath: NSIndexPath(forItem: 0, inSection: key))
            secAttributes.frame = sectionFrame
            secAttributes.zIndex = sectionZIndex
            nextSectionAttribute = cellAttr
            
            secResult.append(secAttributes)
        }
        
        for sec in secResult {
            result.append(sec)
        }
        
        return result
    }
    
}
