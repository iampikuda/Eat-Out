//
//  CacheService.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import RealmSwift

protocol CacheDelegate: class {
    func gotError(_ error: Error)
}

final class CacheService {
    weak var delegate: CacheDelegate?

    func getRestuarants() {
        let q = DispatchQueue(label: "RealmBackgound", qos: .background, attributes: .concurrent)
        q.async {
            do {
                let data = try JsonService().getRestuarantData()
                let restuarants = try JSONDecoder().decode(RestuarantMeta.self, from: data).restaurants
                let realm = try Realm()
                print(data.asJsonString!)
                RealmService.save(restuarants, to: realm)
            } catch {
                self.delegate?.gotError(error)
            }
        }
    }
}

extension Data {
    var asJsonString: String? {
        if let dict = try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] {
            return dict.asJsonString
        }

        return nil
    }
}

extension Dictionary {

    /// Ported from SwiftDebugLog
    /// https://github.com/dtroupe18/SwiftDebugLog/
    var asJsonString: String {
        let invalidJson = "invalid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
}
