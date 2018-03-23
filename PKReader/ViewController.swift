//
//  ViewController.swift
//  PKReader
//
//  Created by qwer on 2018/3/23.
//  Copyright © 2018年 qwer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var pageViewController:UIPageViewController? = {
        
        let xx = UIPageViewController.init(transitionStyle: UIPageViewControllerTransitionStyle.pageCurl, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: [:])
        xx.view.frame = self.view.bounds
        
        xx.delegate = self
        xx.dataSource = self
        
        self.addChildViewController(xx)
        self.view.addSubview(xx.view)
        
        return xx
    }()
    
    var pageModels:[PKPageModel]? = [PKPageModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let bookPath = Bundle.main.path(forResource: "content", ofType: "txt") else{
            return;
        }
       
        self.pageModels = PKReaderTool.getPageModels(bookPath)
        if (self.pageModels?.count)! > 0 {
            let vc = PKReaderVC()
            vc.content = pageModels![0].attributedString
            self.pageViewController?.setViewControllers([vc], direction: UIPageViewControllerNavigationDirection.reverse, animated: false, completion: nil)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! PKReaderVC).pageIndex
        index -= 1
        if index < 0 {
            return nil
        }
        let vc = PKReaderVC()
        vc.pageIndex = index
        vc.content = self.pageModels![index].attributedString
        return vc
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! PKReaderVC).pageIndex
        index += 1
        
        if index > (self.pageModels?.count)!-1 {
            return nil
        }
        
        let vc = PKReaderVC()
        vc.pageIndex = index
        vc.content = self.pageModels![index].attributedString
        return vc
    }
    
}

