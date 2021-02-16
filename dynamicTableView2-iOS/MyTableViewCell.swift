//
//  MyTableViewCell.swift
//  DynamicTableViewTutorial
//
//  Created by kimhyungyu on 2021/01/07.
//

import Foundation
import UIKit
import SwipeCellKit
//mytableviewcell.xib nib 파일을 연결하기 위한 파일

class MyTableViewCell: SwipeTableViewCell {
    //셀이 렌더링 될떄
    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var userContentLabel: UILabel!
    
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var thumbsUpBtn: UIButton!
    
    //피드 데이터
    var feedData: Feed? {
        didSet {
            print("MyTableViewCell - didset / feedData: \(feedData)")
            if let data = feedData {
                heartBtn.tintColor = data.isFavorite ? #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) : .systemGray
                thumbsUpBtn.tintColor = data.isThumbsUp ? #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) :.systemGray
                userContentLabel.text = data.content
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("mytableviewcell -awakefromnib() called")
        
        userProfileImg.layer.cornerRadius = userProfileImg.frame.width/2
    }
}
