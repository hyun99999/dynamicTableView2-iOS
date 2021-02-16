//
//  ViewController.swift
//  DynamicTableViewTutorial
//
//  Created by kimhyungyu on 2021/01/07.
//

import UIKit
import SwipeCellKit

let MY_TABLE_VIEW_CELL_ID = "myTableViewCell"

//피드 데이터 모델
class Feed {
    let content: String
    var isFavorite: Bool = false
    var isThumbsUp: Bool = false
    //생성자
    init(content: String) {
        self.content = content
    }
}

class ViewController: UIViewController {
    
    var contentArray = [
        Feed(content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters"),
        Feed(content: "There are many variations of passages of Lorem Ipsum available"),
        Feed(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
        Feed(content: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.")
    ]

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //셀 리소스 파일 가져오기
        //let myTableViewCellNib = UINib(nibName: "MyTableViewCell", bundle: nil)
        let myTableViewCellNib = UINib(nibName: String(describing: MyTableViewCell.self), bundle: nil)
        
        //셀에 리소스 등록
        self.myTableView.register(myTableViewCellNib, forCellReuseIdentifier: "myTableViewCell")
        self.myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.estimatedRowHeight = 120
        
        //아주 중요
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        
    }
}

//extension
extension ViewController: UITableViewDelegate{}
extension ViewController: UITableViewDataSource{
    //테이블 뷰 셀의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    //각 셀에 대한 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath) as! MyTableViewCell
        
        cell.delegate = self
        //데이터와 UI 연결
        if self.contentArray.count > 0 {
            //기존에는 여기서 바로 contentArray 의 내용을 넣어주었다.
//            cell.userContentLabel.text = contentArray[indexPath.row]
            //만든 모델자체를 cell 에 넣어준다. cell vc 에서는 모델을 가지고 ui로 표현.
            cell.feedData = contentArray[indexPath.row]

        }
        
        return cell
    }
}

//MARK: - SwipeTableViewDelegate
extension ViewController: SwipeTableViewCellDelegate {
    //셀에 대한 스와이프 액션.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        // 데이터
        let dataItem = contentArray[indexPath.row] as Feed
        // 셀
        let cell = tableView.cellForRow(at: indexPath) as! MyTableViewCell
        //액션 방향에 따른 분기 처리
        switch orientation {
        case .left:
            let thumbsUpAction = SwipeAction(style: .default, title: "추천", handler: { action, indexPath in
                print("thumbsUpAction come")
                let updateStauts = !dataItem.isThumbsUp
                dataItem.isThumbsUp = updateStauts
                //0.4초의 간격을 주고 리로드함으로써 자연스러움을 보여줌.
                DispatchQueue.main.asyncAfter(deadline: .now()+0.4, execute: {
                    //현재 스와이픈 한 셀만 리로드.
                    tableView.reloadRows(at: [indexPath], with: .none)
                })
            })
            
            // customize the action appearance
            thumbsUpAction.title = dataItem.isThumbsUp ? "추천 해제" : "추천"
            thumbsUpAction.image = UIImage(systemName: dataItem.isThumbsUp ? "hand.thumbsup" : "hand.thumbsup.fill")
            thumbsUpAction.backgroundColor = dataItem.isThumbsUp ? .systemGray2 : #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            
            return [thumbsUpAction]
            
        case .right:
            let heartAction = SwipeAction(style: .default, title: "좋아요", handler: { action, indexPath in
                print("heartAction come")
                let updateStatus = !dataItem.isFavorite
                dataItem.isFavorite = updateStatus
                cell.hideSwipe(animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.4, execute: {
                    //현재 스와이픈 한 셀만 리로드.
                    tableView.reloadRows(at: [indexPath], with: .none)
                })
            })
            // customize the action appearance
            heartAction.title = dataItem.isFavorite ? "좋아요 해제" : "좋아요"
            heartAction.image = UIImage(systemName: dataItem.isFavorite ? "heart" : "heart.fill")
            heartAction.backgroundColor = dataItem.isFavorite ? .systemGray2 : #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            
            // 바텀 액션 클로저
            let closure: (UIAlertAction) -> Void = {
                (action: UIAlertAction) in
                //셀 액션 닫기
                cell.hideSwipe(animated: true)
                if let selectedTitle = action.title {
                    print("selectedTitle : \(selectedTitle)")
                    //alertController 생성
                    let alertController = UIAlertController(title: selectedTitle, message: "클릭됨", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
            // 더보기 액션
            let moreAction = SwipeAction(style: .default, title: "더보기", handler: {
                action, indexPath in
                print("더보기 액션")
                //alertController 생성
                let bottomAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                bottomAlertController.addAction(UIAlertAction(title: "댓글", style: .default, handler: closure))
                bottomAlertController.addAction(UIAlertAction(title: "상세보기", style: .default, handler: closure))
                bottomAlertController.addAction(UIAlertAction(title: "메세지보기", style: .default, handler: closure))
                bottomAlertController.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: closure))
                
                self.present(bottomAlertController, animated: true, completion: nil)
            })
            // 더보기 액션 꾸미기
            moreAction.image = UIImage(systemName: "elipsis.circle")
            moreAction.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            
            //삭제 액션
            let deleteAction = SwipeAction(style: .destructive, title: "삭제", handler: {
                action, indexPath in
                print("삭제 액션")
                self.contentArray.remove(at: indexPath.row)
            })
            
            //삭제 액션 꾸미기
            deleteAction.image = UIImage(systemName: "trash.fill")
            deleteAction.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            
            return [deleteAction, moreAction, heartAction]
        }
        
//        guard orientation == .right else { return nil }
//
//          let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//              // handle action by updating model with deletion
//          }
//
//          // customize the action appearance
//          deleteAction.image = UIImage(named: "delete")
//
//          return [deleteAction]
    }
    //셀 액션에 대한 옵션 설정
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        
        //액션에 대한 옵션이 구체적으로 들어감.
        options.expansionStyle = orientation == .left ? .selection : .destructive
        options.transitionStyle = .border
        
        return options
        }
    }


