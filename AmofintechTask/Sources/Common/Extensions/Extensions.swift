//
//  Extensions.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import Foundation
import UIKit

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}

extension KeyedDecodingContainer {
    func failsafeDecodeIfPresent<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) -> T? where T: Decodable {
        do {
            return try decodeIfPresent(type, forKey: key)
        } catch {
            return nil
        }
    }
    
    func failsafeDecodeIfPresent(stringForKey key: KeyedDecodingContainer<K>.Key) -> String? {
        if let string = failsafeDecodeIfPresent(String.self, forKey: key) {
            return string
        }

        if let stringAsInteger = failsafeDecodeIfPresent(Int.self, forKey: key) {
            return String(stringAsInteger)
        }

        return nil
    }
}

extension Date {
    init(dateString: String, dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ssZ") {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatString
        self = formatter.date(from: dateString)!
    }
}

extension URL {
    func urlWith(query: String) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.query = query
        return components?.url
    }
}

extension UITableView {
    func register<T: UITableViewCell>(cell: T.Type) where T: Reusable, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle.main)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: Reusable>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("no cell with identifier \(T.defaultReuseIdentifier) could be dequeued")
        }
        return cell
    }
}

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
