//
//  SuggestedContentViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 11/10/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit

class SuggestedContentViewController: UIPageViewController, UIPageViewControllerDataSource {
    var data = gameModelData().gamesData
    var currentIndex = 0
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! SuggestedPageViewController).index
        index -= 1
        return contentViewController(at : index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! SuggestedPageViewController).index
        index += 1
        return contentViewController(at : index)
    }
    
    func contentViewController(at index: Int) -> SuggestedPageViewController? {
        if index < 0 || index >= data.count {
            return nil
        }
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "SuggestedPageViewController") as? SuggestedPageViewController {
            pageContentViewController.imageFile = data[index].imageName
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
