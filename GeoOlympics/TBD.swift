////
////  PostList.swift
////  GeoOlympics
////
////  Created by Sasha on 4/2/21.
////
//
//import SwiftUI
//import MapKit
//
//
//struct LocationList: View {
//
//    @State private var locations: [Location] = []
//    @State private var coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 19.43, longitude: -99.14), span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50 ))
//
//    var body: some View {
//
//        Map(coordinateRegion: $coordinateRegion, annotationItems: locations) {
//            location in
//            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
//                VStack {
//                    Text(location.name)
//                        .font(.caption2)
//                        .bold()
//                    Image(systemName: "star.fill")
//                        .font(.title2)
//                        .foregroundColor(.red)
//                        .shadow(radius: 1)
//                }
//            }
//        }
//                .onAppear(perform:
//                    readFile)
//
//        }
//
//    private func readFile() {
//        if let url = Bundle.main.url(forResource: "map", withExtension: "json"),
//           let data = try? Data(contentsOf: url) {
//            let decoder = JSONDecoder()
//            if let jsonData = try? decoder.decode(JSONData.self, from: data) {
//                self.locations = jsonData.location
//            }
//    }
//
//            }
//
//
//
//
//
//struct JSONData: Decodable {
//    let location: [Location]
//
//}
//
//struct Location: Decodable, Identifiable {
//    let id: Int
//    let name: String
//    let latitude: Double
//    let longitude: Double
//    let year: String
//    let season: String
//}
//}
//struct PostList_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationList()
//    }
//}
