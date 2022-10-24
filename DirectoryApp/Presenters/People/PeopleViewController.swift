//
//  PeopleViewController.swift
//  DirectoryApp
//
//  Created by Przemek on 21/10/2022.
//

import UIKit
import Combine

class PeopleViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let segueDetailsIdentifier = "showPersonDetailsSegue"
    private let cellIdentifier = "personCell"
    private var cancellables = Set<AnyCancellable>()
    
    var viewModel: PeopleViewModel = PeopleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        bindViewModelState()
        let apiRequest = ApiRequest(baseUrl: EndPoint.baseURL, path: Path.people, params: [:])
        viewModel.getPeople(apiRequest: apiRequest)
    }
    
    private func bindViewModelState() {
        let cancellable = viewModel.$state.sink { _ in
            
        } receiveValue: { [weak self] currentState in
            DispatchQueue.main.async {
                self?.updateUI(state: currentState)
            }
        }
        self.cancellables.insert(cancellable)
    }
    
    private func updateUI(state: ViewState) {
        switch state {
        case .none:
            break
        case .loading:
            activityIndicator.startAnimating()
        case .finishedLoading:
            activityIndicator.stopAnimating()
            tableView.reloadData()
        case .error(let message):
            activityIndicator.stopAnimating()
            tableView.reloadData()
            self.showAlert(message: message)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueDetailsIdentifier {
            if let detailsVC = segue.destination as? PersonDetailsViewController {
                let indexPath = self.tableView.indexPathForSelectedRow ?? IndexPath()
                let person = viewModel.getPerson(for: indexPath.row)
                detailsVC.data = person
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}

// MARK: - TableViewDataSource methods
extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPeopleCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PeopleTableViewCell else {
            return UITableViewCell()
        }
        
        let person = viewModel.getPerson(for: indexPath.row)
        cell.nameLbl.text = "\(person.firstName) \(person.lastName)"
        
        return cell
    }
}

// MARK: - TableViewDelegate methods
extension PeopleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: segueDetailsIdentifier, sender: self)
    }
}
