//
//  JsonService.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import Foundation

struct JsonService {
    func getRestuarantData() throws -> Data {
        let fileName = "iOS sample"
        let ext = ".json"

        guard let path = Bundle.main.path(forResource: fileName, ofType: ext) else {
            throw(NSError(
                domain: "",
                code: 404,
                userInfo: [NSLocalizedDescriptionKey: "File \(fileName) was not found in bundle"]
            ))
        }

        return try Data(contentsOf: URL(fileURLWithPath: path))
    }
}
