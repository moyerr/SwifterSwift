//
//  CGRectExtensions.swift
//  SwifterSwift
//
//  Created by Robbie Moyer on 2/16/18.
//  Copyright © 2018 SwifterSwift
//

import UIKit

// MARK: - Methods
public extension CGRect {
    
    /// SwifterSwift: Adjusts a rectangle by the given edge insets
    ///
    ///     let safeAreaRect = view.frame.inset(by: view.safeAreaInsets)
    ///
    /// - Parameter insets: The edge insets to be applied to the rectangle
    /// - Returns: A rectangle that is adjusted by the `UIEdgeInsets` passed
    ///            in `insets`
    public func inset(by insets: UIEdgeInsets) -> CGRect {
        return UIEdgeInsetsInsetRect(self, insets)
    }
    
}
