//
//  UserViewController.swift
//  QuinielaMatriz
//
//  Created by User on 3/25/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

protocol AddForecastUser {
    func selectUserResult(home: Int, away: Int, image: UIImage, name: String)
    
    func unselectUserResult(home: Int, away: Int)
}

class UserViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var delegate: AddForecastUser?
    
    let users: [[String: String]] = [
        [
            "user": "Juan",
            "avatar": "avatar0"
        ],
        [
            "user": "Aaron",
            "avatar": "avatar1"
        ],
        [
            "user": "Luis",
            "avatar": "avatar2"
        ],
        [
            "user": "Maria",
            "avatar": "avatar3"
        ],
        [
            "user": "Luisa",
            "avatar": "avatar4"
        ],
        [
            "user": "Pablo",
            "avatar": "avatar5"
        ],
        [
            "user": "Vicente",
            "avatar": "avatar6"
        ],
        [
            "user": "Julian",
            "avatar": "avatar7"
        ],
        [
            "user": "Jazmin",
            "avatar": "avatar8"
        ],
        [
            "user": "Sofi",
            "avatar": "avatar9"
        ],
        [
            "user": "Karen",
            "avatar": "avatar10"
        ],
        [
            "user": "Saul",
            "avatar": "avatar11"
        ],
        [
            "user": "Simon",
            "avatar": "avatar12"
        ],
        [
            "user": "Raul",
            "avatar": "avatar13"
        ],
        [
            "user": "Ana",
            "avatar": "avatar14"
        ],
        [
            "user": "Elena",
            "avatar": "avatar15"
        ],
        [
            "user": "Mario",
            "avatar": "avatar16"
        ],
        [
            "user": "Cristian",
            "avatar": "avatar17"
        ],
        [
            "user": "Ingrid",
            "avatar": "avatar18"
        ],
        [
            "user": "Paco",
            "avatar": "avatar19"
        ],
        [
            "user": "Oscar",
            "avatar": "avatar20"
        ],
        [
            "user": "German",
            "avatar": "avatar21"
        ],
        [
            "user": "Raquel",
            "avatar": "avatar22"
        ],
        [
            "user": "Carlos",
            "avatar": "avatar23"
        ],
        [
            "user": "Nere",
            "avatar": "avatar24"
        ]
    ]
    var (homeUserResult, awayUserResult): (Int, Int) = (0, 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UserViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let avatar = users[indexPath.item]["avatar"], let imageSelected = UIImage(named: avatar), let name = users[indexPath.item]["user"] {
            delegate?.selectUserResult(home: homeUserResult, away: awayUserResult, image: imageSelected, name: name)
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension UserViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as! UsersCollectionViewCell
        if let avatar = users[indexPath.item]["avatar"] {
            cell.userImage?.image = UIImage(named: avatar)
        }
        if let name = users[indexPath.item]["user"] {
            cell.userNameLabel?.text = name
        }
        return cell
    }
    
    
}
