//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Alyona Sabitskaya  on 11.07.2021.
//

import UIKit

struct UIHelper {
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout{
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        let itemHeight                  = itemWidth + 40
        
        let layout                      = UICollectionViewFlowLayout()
        layout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize                 = CGSize(width: itemWidth, height: itemHeight)
        
        return layout
    }
}
