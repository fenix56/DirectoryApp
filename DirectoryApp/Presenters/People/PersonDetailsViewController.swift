//
//  PersonDetailsViewController.swift
//  DirectoryApp
//
//  Created by Przemek on 24/10/2022.
//

import UIKit

class PersonDetailsViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var jobTitleLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var favColorLbl: UILabel!
    @IBOutlet weak var joinedDateLbl: UILabel!
    
    var data: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    private func setup() {
        guard let data = data else {
            return
        }
        setAvatarImage(urlString: data.avatarImageURL?.absoluteString ?? "")
        firstNameLbl.text = data.firstName
        lastNameLbl.text = data.lastName
        jobTitleLbl.text = data.jobTitle
        emailLbl.text = data.email
        favColorLbl.text = data.favColour
        setJoinedDate(dateString: data.createdAt)
    }
    
    private func setAvatarImage(urlString: String) {
        let networkManager = NetworkManager()
        let apiRequest = ApiRequest(baseUrl: urlString, path: "", params: [:])
        networkManager.get(apiRequest: apiRequest, type: Data.self) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.avatarImageView.image = UIImage(data: data)
                case .failure:
                    self?.avatarImageView.image = UIImage(systemName: "person.crop.circle")
                }
            }
        }
    }
    
    func setJoinedDate(dateString: String) {
        joinedDateLbl.text = dateString.toDateFormat()
    }
}
