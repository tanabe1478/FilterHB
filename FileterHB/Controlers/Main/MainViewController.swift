//
//  ViewController.swift
//  FileterHB
//
//  Created by 田辺信之 on 2018/11/06.
//  Copyright © 2018年 田辺信之. All rights reserved.
//

import UIKit
import Models
import XLPagerTabStrip

class MainViewController: ButtonBarPagerTabStripViewController {
    @IBOutlet weak var buttonBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerTopConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        do {
            // custmize style of header
            // color

            settings.style.buttonBarBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            settings.style.buttonBarItemBackgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            settings.style.buttonBarItemTitleColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            settings.style.selectedBarBackgroundColor = UIColor.white

            // sizes and spaces
            settings.style.buttonBarMinimumLineSpacing = 5.0
            settings.style.selectedBarHeight = 5.0
            settings.style.buttonBarLeftContentInset = 1.0
            settings.style.buttonBarRightContentInset = 1.0

            settings.style.buttonBarItemsShouldFillAvailableWidth = true
        }
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        containerTopConstraint.constant = self.view.safeAreaInsets.top + buttonBarHeightConstraint.constant
    }
    @IBAction func tappedSettingButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Setting", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "Setting") as? SettingViewController else { fatalError() }
        self.present(vc, animated: true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        // 管理されるViewControllerを返す処理
        let home = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "First") as? EntryTableViewController
        home?.datasource.urlList = .home
        home?.itemInfo = "総合"

        let tech = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "First") as? EntryTableViewController
        tech?.datasource.urlList = .technology
        tech?.itemInfo = "テクノロジー"

        let study = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "First") as? EntryTableViewController
        study?.datasource.urlList = .study
        study?.itemInfo = "学び"

        let social = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "First") as? EntryTableViewController
        social?.datasource.urlList = .social
        social?.itemInfo = "世の中"

        let economics = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "First") as? EntryTableViewController
        economics?.datasource.urlList = .economics
        economics?.itemInfo = "政治経済"

        let life = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "First") as? EntryTableViewController
        life?.datasource.urlList = .life
        life?.itemInfo = "生活"

        let fun = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "First") as? EntryTableViewController
        fun?.datasource.urlList = .fun
        fun?.itemInfo = "おもしろ"

        let entertainment = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "First") as? EntryTableViewController
        entertainment?.datasource.urlList = .entertainment
        entertainment?.itemInfo = "エンタメ"

        let game = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "First") as? EntryTableViewController
        game?.datasource.urlList = .game
        game?.itemInfo = "アニメとゲーム"

        let childViewControllers = [home, tech, study, social, economics, life, fun, entertainment, game]
        return childViewControllers.compactMap({$0})
    }
}
