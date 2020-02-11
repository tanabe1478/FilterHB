//
//  BookmarksViewController.swift
//  FileterHB
//
//  Created by 田辺信之 on 2018/12/06.
//  Copyright © 2018年 田辺信之. All rights reserved.
//

import UIKit
import Models

class BookmarksViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var tableView: UITableView!
    var bookmarksDataSource: BookmarksDataSource = BookmarksDataSource()
    var urlString: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        tableView.register(UINib(nibName: BookmarkCell.nibName, bundle: nil), forCellReuseIdentifier: BookmarkCell.nibName)
        tableView.dataSource = bookmarksDataSource
        tableView.delegate = self
        guard let urlString = urlString else { return }
        HatenaEntry.fetch(urlString: urlString) { errorOrData in
            switch errorOrData {
            case let .left(error):
                fatalError("\(error)")
            case var .right(hatena):
                hatena.decimateNoTextComment()
                hatena.thinOutBlockedUser()
                self.bookmarksDataSource.hatenaEntry = hatena
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    @IBAction func tapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}

extension BookmarksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "User") as? UserViewController else { fatalError() }
        let userId = bookmarksDataSource.getUserId(indexPath: indexPath)
        vc.dataSource.userId = userId
        vc.dataSource.iconUrl = bookmarksDataSource.getIconUrl(index: indexPath.row)
        vc.dataSource.urlString = "http://b.hatena.ne.jp/\(userId)/bookmark.rss"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
