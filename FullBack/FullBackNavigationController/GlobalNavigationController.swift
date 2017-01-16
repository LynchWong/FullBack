//
//  GlobalNavigationController.swift
//  FullBack
//
//  Created by Lynch Wong on 1/16/17.
//  Copyright © 2016 Lynch Wong. All rights reserved.
//

import UIKit

/// 最外层的 UINavigationController，已经隐藏导航栏。

class GlobalNavigationController: UINavigationController {
    
    init(with rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [warpper(with: rootViewController)]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard viewControllers.count > 0 else {
            return
        }
        viewControllers = [warpper(with: viewControllers[0])]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white // 设置背景色，防止出现黑色背景条。
        
        delegate = self
        interactivePopGestureRecognizer?.delegate  = self
        setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - WarpperController

extension GlobalNavigationController {
    
    fileprivate func warpper(with viewController: UIViewController) -> WarpperController {
        let baseNavigationController = BaseNavigationController(nibName: nil, bundle: nil)
        baseNavigationController.viewControllers = [viewController]
        return WarpperController(with: baseNavigationController)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension GlobalNavigationController: UIGestureRecognizerDelegate {}

// MARK: - UINavigationControllerDelegate

extension GlobalNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // 修复 interactivePopGestureRecognizer 卡住的 BUG，interactivePopGestureRecognizer is freezing app
        let isRootVC = viewController === viewControllers[0]
        interactivePopGestureRecognizer?.isEnabled = !isRootVC
    }
}

extension GlobalNavigationController {
    
    override var shouldAutorotate: Bool {
        guard let topViewController = topViewController as? WarpperController else {
            return true
        }
        return topViewController.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let topViewController = topViewController else {
//            if Device.isPad() {
//                return .all
//            } else {
                return .allButUpsideDown
//            }
        }
        return topViewController.supportedInterfaceOrientations
    }
}

extension GlobalNavigationController {
    
    override var childViewControllerForStatusBarHidden: UIViewController? {
        return topViewController
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
