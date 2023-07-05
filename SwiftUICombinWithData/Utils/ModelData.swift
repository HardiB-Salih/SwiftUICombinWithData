//
//  ModelData.swift
//  SwiftUICombinWithData
//
//  Created by HardiB.Salih on 6/29/23.
//

import Foundation
import CodableCSV

//var faqData: [FAQ] = load("faqData.json")


/// Loads and parses a JSON file from the main bundle into the specified Codable type.
/// - Parameters:
///   - filename: The name of the JSON file (without file extension) to load.
/// - Returns: The decoded object of type `T`.
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


/// Loads a CSV file using CodableCSV library and decodes it into an array of the specified type.
///
/// - Parameters:
///   - filename: The name of the CSV file (without the extension) located in the main bundle.
///   - delimiter: The delimiter character used in the CSV file. Default value is a comma (",").
///
/// - Returns: An array of the decoded type.
///
/// - Note: This function relies on the [CodableCSV](https://github.com/dehesa/CodableCSV.git) library.
///
func loadCSV<T: Decodable>(filename: String, delimiter: Delimiter.Field = ",") -> [T] {
    let decoder = CSVDecoder {
        $0.encoding = .utf8
        $0.delimiters.field = delimiter
        $0.headerStrategy = .firstLine
        $0.bufferingStrategy = .keepAll
    }

    do {
        let url = Bundle.main.url(forResource: filename, withExtension: "csv")!
        let csvData = try Data(contentsOf: url)
        let decodedData = try decoder.decode([T].self, from: csvData)
        return decodedData
    } catch {
        fatalError("Couldn't parse CSV file: \(error)")
    }
}

// Usage example
let faqData: [FAQ] = loadCSV(filename: "faq-data", delimiter: "|")
