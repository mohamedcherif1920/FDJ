//
//  UIViwController+Extension.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import UIKit

extension UIViewController {
    static func initFromNib() -> Self {
        func instanceFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: self), bundle: nil)  }
        return instanceFromNib()
    }
}
