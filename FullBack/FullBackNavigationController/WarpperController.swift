//
//  WarpperController.swift
//  FullBack
//
//  Created by Lynch Wong on 1/16/17.
//  Copyright © 2016 Lynch Wong. All rights reserved.
//

import UIKit

/// 容器 Controller，用来包装 BaseNavigationController。

class WarpperController: UIViewController {

    let warpperedNavigationController: BaseNavigationController
    
    init(with warpperedNavigationController: BaseNavigationController) {
        self.warpperedNavigationController = warpperedNavigationController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(warpperedNavigationController)
        warpperedNavigationController.view.frame = view.bounds
        view.addSubview(warpperedNavigationController.view)
        warpperedNavigationController.didMove(toParentViewController: self)
    }
}

extension WarpperController {
    
    override var shouldAutorotate: Bool {
        return warpperedNavigationController.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return warpperedNavigationController.supportedInterfaceOrientations
    }
}

extension WarpperController {
    
    override var childViewControllerForStatusBarHidden: UIViewController? {
        return warpperedNavigationController
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return warpperedNavigationController
    }
}
