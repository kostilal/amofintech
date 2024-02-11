//
//  NSObjectExtension.swift
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
    func register<T: UITableViewCell>(_ name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}
