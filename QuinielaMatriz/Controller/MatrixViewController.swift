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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Parameters

    let homeTeam = "Rams"
    let awayTeam = "Pats"
    let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 3.0, right: 3.0)
    let originalCellColor: UIColor = UIColor(hexString: "99FFAB")!
    var forecast: Forecast = Forecast()
    var (homeUserResult, awayUserResult): (Int, Int) = (0, 0)
    var cellWidth: CGFloat = CGFloat(50.0)
    var cellHeight: CGFloat = CGFloat(50.0)
    
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // Some code for device rotation
        if UIDevice.current.orientation.isLandscape {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        //navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
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
        let paddingSpace = sectionInsets.right * CGFloat(forecast.columns + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let availableHeight = collectionView.frame.height - paddingSpace
        let minimumSpace = availableHeight < availableWidth ? availableHeight : availableWidth
        cellHeight = CGFloat(minimumSpace) / CGFloat(forecast.columns)
        cellWidth = CGFloat(minimumSpace) / CGFloat(forecast.columns)
        //print("height: \(availableHeight), width: \(availableWidth), cellHeight: \(cellHeight), cellWidth: \(cellWidth)")
    }
    
    func clearCell(with cell: CollectionViewCell) {
        cell.userImage.image = nil
        cell.userImage.isHidden = true
        cell.backgroundColor = originalCellColor
        cell.myLabel.text = ""
    }
    
    func isHeader(at indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 || indexPath.item == 0
    }
    
    // MARK: - Actions
    
    @IBAction func clearAllClicked(_ sender: UIBarButtonItem) {
        Alert.showAlertWithActions(on: self, with: "Delete All", message: "Are you sure you want to delete the forecast for all users?") { (action) in
            self.forecast.resetResults()
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Delegate Protocols

extension MatrixViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isHeader(at: indexPath) { return }
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
        clearCell(with: cell)
        if isHeader(at: indexPath) {
            cell.backgroundColor = UIColor.clear
            if indexPath.section == 0 {
                cell.myLabel.text = forecast.awaySetScores[indexPath.item].joined(separator: "-")
            } else if (indexPath.item == 0) {
                cell.myLabel.text = forecast.homeSetScores[indexPath.section].joined(separator: "-")
            }
        } else {
            if let user = forecast.results[indexPath.section][indexPath.item] {
                cell.userImage.image = user.avatar
                cell.userImage.isHidden = false
            }
        }
        return cell
    }
}

// MARK: - DelegateFlowLayout Protocols

extension MatrixViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
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
        Alert.showAlertWithActions(on: self, with: "Delete", message: "Are you sure you want to delete the forecast for this user?") { (action) in
            self.forecast.results[home][away] = nil
            self.collectionView.reloadData()
        }
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
