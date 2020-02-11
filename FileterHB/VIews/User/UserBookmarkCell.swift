//
//  UserBookmarkCell.swift
//  FileterHB
//
//  Created by 田辺信之 on 2019/02/18.
//  Copyright © 2019 田辺信之. All rights reserved.
//

import UIKit
import Models

class UserBookmarkCell: UITableViewCell, InstantiatableFromNib {
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var commentLabel: UILabel!
    @IBOutlet weak private var iconImageView: UIImageView!
    var index: Int?
    weak var dataSource: UserBookmarkCellDataSource? {
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

    private func setLayout() {
        guard let dataSource = dataSource, let index = index, let rssItems = dataSource.rssItems else { return }
        DispatchQueue.main.async {
            self.titleLabel.text = rssItems[index].title
            self.commentLabel.text = rssItems[index].description
            self.iconImageView.sd_setImage(with: dataSource.iconUrl)
        }
    }

    override func prepareForReuse() {
        iconImageView.image = nil
    }
}

protocol UserBookmarkCellDataSource: class {
    var rssItems: [RSSItem]? { get set }
    var iconUrl: URL! { get set }
}
