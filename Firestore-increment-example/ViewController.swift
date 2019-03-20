//
//  ViewController.swift
//  Firestore-increment-example
//
//  Created by suguru-kishimoto on 2019/03/20.
//  Copyright © 2019 Komerco. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet private weak var pathLabel: UILabel! {
        didSet {
            pathLabel.text = "path: \(counterRef.path)"
        }
    }
    @IBOutlet private weak var countLabel: UILabel!
    private let db = Firestore.firestore()
    private var counterRef: DocumentReference {
        return db.collection("counters").document("counter")
    }
    private var listener: ListenerRegistration?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCounter()
    }

    private func loadCounter() {
        counterRef.getDocument { [weak self] snapshot, error in
            guard let self = self else { return }
            if snapshot?.exists == true {
                self.update(snapshot)
            } else {
                self.counterRef.setData(["count": 0])
                self.update(snapshot)
            }
        }

        listener = counterRef.addSnapshotListener(includeMetadataChanges: true) { snapshot, _ in
            if snapshot?.exists == true {
                self.update(snapshot)
            }
        }
    }

    private func update(_ snapshot: DocumentSnapshot?) {
        countLabel.text = "count: \(snapshot?.data()?["count"] as? Int ?? 0)"
    }

    @IBAction private func increment(_: UIButton) {
        FieldValue.increment(1.0)
        counterRef.updateData(["count": FieldValue.increment(Int64(1))])
    }

    @IBAction private func decrement(_: UIButton) {
        counterRef.updateData(["count": FieldValue.increment(Int64(-1))])
    }
}

