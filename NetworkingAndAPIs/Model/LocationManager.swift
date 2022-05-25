//
//  LocationManager.swift
//  NetworkingAndAPIs
//
//  Created by Laptop World on 21/10/1443 AH.
//

import Foundation

//protocol LocationManagerDelegate {
//    func didUpdateLocations(_ locationManager: LocationManager ,location: LocationModel)
//    func DidFailWithError(error: Error)
//}
//
//struct LocationManager {
//    let locationURL = "https://iskan.roqay.solutions/api/v1/locations?page=1"
//
//
//
//    var delegate: LocationManagerDelegate?
//
////    func fetchLocation(){
////        let urlString = "\(locationURL)"
////        performRequest(with: urlString)
////    }
//
//    func performRequest(with urlString: String){
//
//        if let url = URL(string: urlString){
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) {  (data, response, error) in
//                if error != nil {
//                    delegate?.DidFailWithError(error: error!)
//                    return
//                }
//                if let dataTask = data {
//                    //let DataString = String(data: dataTask, encoding: .utf8)
//
//                    if let location = self.parseJson(locationData: dataTask){
//                        delegate?.didUpdateLocations(self, location: location)
//                    }
//
//                }
//            }
//            task.resume()
//        }
//
//    }
//
//    func parseJson(locationData: Data) -> LocationModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(LocationData.self, from: locationData)
//            let id = decodedData.data[1].id
//            let name = decodedData.data[1].name
//            let address = decodedData.data[1].address
//            let photo = decodedData.data[1].photo
//            let locationModel: LocationModel = LocationModel(locationId: id, locationName: name, locationAddress: address, locationPhoto: photo)
//            return locationModel
//        } catch {
//
//            delegate?.DidFailWithError(error: error)
//            return nil
//        }
//
//    }
//}
