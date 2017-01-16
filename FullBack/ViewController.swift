//
//  ViewController.swift
//  FullBack
//
//  Created by Lynch Wong on 1/16/17.
//  Copyright © 2017 Lynch Wong. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "View") else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
