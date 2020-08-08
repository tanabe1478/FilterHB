//
//  FirstViewController.swift
//  FileterHB
//
//  Created by 田辺信之 on 2018/11/08.
//  Copyright © 2018年 田辺信之. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import XLPagerTabStrip

class EntryTableViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 200
            tableView.rowHeight = UITableView.automaticDimension
            tableView.delaysContentTouches = false
        }
    }

    let viewModel: EntryTableViewModel = EntryTableViewModel()
    var datasource = EntrysDataSource()
    private let disposeBag = DisposeBag()

    // ボタンのタイトル
    var itemInfo: IndicatorInfo!
    let refreshControl = UIRefreshControl()

    private func refreshControlInit() {
        refreshControl.tintColor = UIColor.blue
        tableView.refreshControl = refreshControl
        refreshControl.attributedTitle = NSAttributedString(string: "読込中")
        refreshControl.addTarget(self, action: #selector(self.refresh(sender:)), for: .valueChanged)
    }

    @objc func refresh(sender: UIRefreshControl) {
        sender.beginRefreshing()
        datasource.getRSS(tableView: tableView, urlList: datasource.urlList!)
        sender.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControlInit()
        tableView.dataSource = datasource
        tableView.delegate = self
        datasource.registerCell(tableView: tableView)
        datasource.getRSS(tableView: tableView, urlList: datasource.urlList!)
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.

        rx.viewDidAppear
            .subscribe(onNext: {
                print("hoge")
                self.viewModel.input.viewDidAppear()
            })
            .disposed(by: disposeBag)

        //            .disposed(by: disposeBag)

    }

    // 必須
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = datasource.getUrl(index: indexPath.row) else {
            return
        }
        let tabvc = WebTabController()
        tabvc.setVC(urlString: url)
        self.navigationController?.pushViewController(tabvc, animated: true)
    }

    @IBAction func tapFilterLaunchButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Filter", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Filter")
        self.present(vc, animated: true)
    }
}
