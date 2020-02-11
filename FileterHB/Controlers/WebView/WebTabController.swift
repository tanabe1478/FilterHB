//
//  WebTabController.swift
//  FileterHB
//
//  Created by 田辺信之 on 2018/12/06.
//  Copyright © 2018年 田辺信之. All rights reserved.
//

import UIKit

class WebTabController: UITabBarController {

    func setVC(urlString url: String) {
        var viewControllers: [UIViewController] = []

        let storyboard: UIStoryboard = UIStoryboard(name: "WebView", bundle: nil)
        guard let first: WebViewController = storyboard.instantiateViewController(withIdentifier: "WebView") as? WebViewController else { return }
        first.urlString = url
        first.tabBarItem = UITabBarItem(title: "WebView", image: nil, tag: 1)
        let secondStoryboard: UIStoryboard = UIStoryboard(name: "Bookmarks", bundle: nil)
        guard let second: BookmarksViewController = secondStoryboard.instantiateViewController(withIdentifier: "Bookmarks") as? BookmarksViewController else { return }
        second.urlString = url
        second.tabBarItem = UITabBarItem(title: "Bookmarks", image: nil, tag: 2)

        viewControllers.append(first)
        viewControllers.append(second)
        self.setViewControllers(viewControllers, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
