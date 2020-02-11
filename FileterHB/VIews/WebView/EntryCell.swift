//
//  EntryCell.swift
//  FileterHB
//
//  Created by 田辺信之 on 2018/11/10.
//  Copyright © 2018年 田辺信之. All rights reserved.
//

import UIKit
import Models

class EntryCell: UITableViewCell, InstantiatableFromNib {
    @IBOutlet weak private var iCatchImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var countLabel: UILabel!
    var index: Int!
    weak var dataSource: EntryCellDataSource? {
        didSet { setLayout() }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setLayout() {
        let altUrl = "http://hatenacorp.jp/images/hatenaportal/company/resource/hatena-bookmark-logo-s.png"
        guard let rssItem = dataSource?.rssItems?[index] else { return }
        let url = URL(string: (rssItem.imageUrl == "") ? altUrl : rssItem.imageUrl)
        self.titleLabel.text = rssItem.title
        self.descriptionLabel.text = rssItem.description
        self.countLabel.text = "\(rssItem.bookmarkCount)Users"
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.iCatchImageView.image = image
                }
            } catch let err {
                print("\(err.localizedDescription)")
            }
        }
    }

    override func prepareForReuse() {
        iCatchImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
        countLabel.text = nil
    }
}

protocol EntryCellDataSource: AnyObject {
    var rssItems: [RSSItem]? { get set }
}
