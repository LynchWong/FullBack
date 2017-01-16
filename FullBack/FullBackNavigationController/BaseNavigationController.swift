//
//  BaseNavigationController.swift
//  FullBack
//
//  Created by Lynch Wong on 1/16/17.
//  Copyright © 2016 Lynch Wong. All rights reserved.
//

import UIKit

/// 内容 Controller 的 UINavigationController，是 WarpperController 的 Child。

class BaseNavigationController: UINavigationController {

    // BaseNavigationController 的 navigationController 就是 GlobalNavigationController
    
    override func popViewController(animated: Bool) -> UIViewController? {
        return navigationController?.popViewController(animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return navigationController?.popToRootViewController(animated: animated)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spaceItem.width = -10.0
        let backItem  = UIBarButtonItem(image: UIImage(named: "naviback"), style: .plain, target: self, action: #selector(BaseNavigationController.back))
        
        viewController.navigationItem.leftBarButtonItems = [spaceItem, backItem]
        
        let baseNavigationController = BaseNavigationController(nibName: nil, bundle: nil)
        baseNavigationController.viewControllers = [viewController]
        
        let warrperController = WarpperController(with: baseNavigationController)
        warrperController.hidesBottomBarWhenPushed = viewController.hidesBottomBarWhenPushed
        
        navigationController?.pushViewController(warrperController, animated: true)
    }
    
    func back() {
        _ = navigationController?.popViewController(animated: true)
    }
}

extension BaseNavigationController {
    
    override var shouldAutorotate: Bool {
        guard let topViewController = topViewController else {
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

extension BaseNavigationController {
    
    override var childViewControllerForStatusBarHidden: UIViewController? {
        return topViewController
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
