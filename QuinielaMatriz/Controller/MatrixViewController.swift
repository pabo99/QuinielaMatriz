//
//  MatrixViewController.swift
//  QuinielaMatriz
//
//  Created by User on 3/24/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import ChameleonFramework

class MatrixViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var homeResult1: UILabel!
    @IBOutlet weak var homeResult2: UILabel!
    @IBOutlet weak var homeResult3: UILabel!
    @IBOutlet weak var homeResult4: UILabel!
    @IBOutlet weak var homeResult5: UILabel!
    @IBOutlet weak var awayResult1: UILabel!
    @IBOutlet weak var awayResult2: UILabel!
    @IBOutlet weak var awayResult3: UILabel!
    @IBOutlet weak var awayResult4: UILabel!
    @IBOutlet weak var awayResult5: UILabel!
    
    // MARK: - Parameters

    let homeTeam = "Rams"
    let awayTeam = "Pats"
    var forecast: Forecast = Forecast()
    var (homeUserResult, awayUserResult): (Int, Int) = (0, 0)
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCommonLabels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUser" {
            let destinationVC = segue.destination as! UserViewController
            destinationVC.delegate = self
            (destinationVC.homeUserResult, destinationVC.awayUserResult) = (homeUserResult, awayUserResult)
        }
    }
    
    // MARK: - Helpers
    
    func setCommonLabels() {
        homeTeamLabel.rotate(degrees: -90)
        homeTeamLabel.text = homeTeam
        awayTeamLabel.text = awayTeam
        homeResult1.text = forecast.homeSetScores[0].joined(separator: "-")
        homeResult2.text = forecast.homeSetScores[1].joined(separator: "-")
        homeResult3.text = forecast.homeSetScores[2].joined(separator: "-")
        homeResult4.text = forecast.homeSetScores[3].joined(separator: "-")
        homeResult5.text = forecast.homeSetScores[4].joined(separator: "-")
        awayResult1.text = forecast.awaySetScores[0].joined(separator: "-")
        awayResult2.text = forecast.awaySetScores[1].joined(separator: "-")
        awayResult3.text = forecast.awaySetScores[2].joined(separator: "-")
        awayResult4.text = forecast.awaySetScores[3].joined(separator: "-")
        awayResult5.text = forecast.awaySetScores[4].joined(separator: "-")
    }
}

// MARK: - Delegate Protocols

extension MatrixViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _ = forecast.results[indexPath.section][indexPath.item] {
            unselectUserResult(home: indexPath.section, away: indexPath.item)
        } else {
            (homeUserResult, awayUserResult) = (indexPath.section, indexPath.item)
            performSegue(withIdentifier: "goToUser", sender: self)
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return forecast.rows
    }
}

// MARK: - DataSource Protocols

extension MatrixViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast.columns
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.userImage.image = nil
        if let user = forecast.results[indexPath.section][indexPath.item] {
            cell.userImage.image = user.avatar
        } else {
            cell.userImage.image = UIImage(named: "available")
        }
        cell.layer.borderWidth = 0
        return cell
    }
}

// MARK: - Forecast Protocols

extension MatrixViewController: AddForecastUser {
    func selectUserResult(home: Int, away: Int, image: UIImage, name: String) {
        let user = User()
        user.name = name
        user.avatar = image
        forecast.results[home][away] = user
        collectionView.reloadData()
    }
    
    func unselectUserResult(home: Int, away: Int) {
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete the forecast for this user?", preferredStyle: .actionSheet)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            self.forecast.results[home][away] = nil
            self.collectionView.reloadData()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

extension UIView {
    func rotate(degrees: CGFloat) {
        rotate(radians: CGFloat.pi * degrees / 180.0)
    }
    
    func rotate(radians: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
}
