import UIKit

let json1 = """
{
    "latitude": 44.4,
    "longitude": 55.5,
}
"""

struct Coordinate: Codable {
    var latitude : Double
    var longitude: Double
}

let jsonData = json1.data(using: .utf8)!
let decoder = JSONDecoder()
let result = try decoder.decode(Coordinate.self, from: jsonData)

result
result.latitude
result.longitude


let json2 = """
{
    "name": "Tatooine",
    "foundingYear": 1977,
    "location": {
        "latitude": 44.4,
        "longitude": 55.5,
    },
}
"""

struct Planet: Codable {
    var name: String
    var foundingYear: Int
    var location: Coordinate
}

let jsonData2 = json2.data(using: .utf8)!
let result2 = try JSONDecoder().decode(Planet.self, from: jsonData2)

print(result2)

let json3 = """
{
    "planet_name": "Tatooine",
    "founding_year": 1977,
    "location": {
        "latitude": 44.4,
        "longitude": 55.5,
    },
}
"""

struct OtherPlanet: Codable {
    var name: String
    var foundingYear: Int
    var location: Coordinate
    
    enum CodingKeys: String, CodingKey {
        case name = "planet_name"
        case foundingYear = "founding_year"
        case location
    }
}

let data3 = json3.data(using: .utf8)!
let result3 = try! JSONDecoder().decode(OtherPlanet.self, from: data3)

print(result3)

//weathery app demo


