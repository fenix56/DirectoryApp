//
//  RoomsViewController.swift
//  DirectoryApp
//
//  Created by Przemek on 21/10/2022.
//

import UIKit
import Combine

class RoomsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "roomCell"
    private var cancellables = Set<AnyCancellable>()
    
    var viewModel: RoomsViewModel = RoomsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        tableView.dataSource = self
        bindViewModelState()
        let apiRequest = ApiRequest(baseUrl: EndPoint.baseURL, path: Path.rooms, params: [:])
        viewModel.getRooms(apiRequest: apiRequest)
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
}

extension RoomsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRoomsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RoomTableViewCell else {
            return UITableViewCell()
        }
        
        let room = viewModel.getRoom(for: indexPath.row)
        cell.setupCell(with: room)
        
        return cell
    }
}
