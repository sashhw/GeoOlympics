//
//  ContentView.swift
//  GeoOlympics
//
//  Created by Sasha on 4/2/21.
//

import SwiftUI
import MapKit


struct ContentView: View {
    @State  var locations: [Location] = []
    @State  var coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 24.749561, longitude: 42.143841), span: MKCoordinateSpan(latitudeDelta: 150, longitudeDelta: 150 ))
   @State var showingAlert = false
    @State var presentingModal = false
 
    var body: some View {
       
        Map(coordinateRegion: $coordinateRegion, annotationItems: locations) {
            location in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                VStack {
                    Button(location.name) {
                        showingAlert = true
                    }
                    .foregroundColor(.primary)
                     .font(.callout)
                    .sheet(isPresented: $showingAlert) {
                        SheetView(locations: location, presentedAsModal: $presentingModal)
                    }
                    
                       
                    if location.season == "Winter" {
                    Image(systemName: "snow")
                        .font(.title)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2)
                        
                }
                    else {
                        Image(systemName: "sun.max")
                            .font(.title)
                            .foregroundColor(.yellow)
                            .shadow(color: .black, radius: 2)
                        
                            
                    }
                }
            }
        }
        .onAppear(perform: readFile)
               
        }
    
   func readFile() {
        if let url = Bundle.main.url(forResource: "locations", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(JSONData.self, from: data) {
                self.locations = jsonData.locations
            }
    }
  

            }





struct JSONData: Decodable {
    let locations: [Location]

}
    
 struct Location: Decodable, Identifiable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let year: String
    let season: String
    var image: String
}
    
    

    struct SheetView: View {
       
        @State var locations: ContentView.Location
        @Binding var presentedAsModal: Bool
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            VStack {
          Spacer()
                Text(locations.name)
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding()
                HStack {
                    
                    if locations.season == "Summer" {
                        Text(locations.season)
                            .font(.title3)
                            .fontWeight(.heavy)
                            .foregroundColor(.yellow)
                            .shadow(color: .black, radius: 2)
                        
                    } else {
                        Text(locations.season)
                            .font(.title3)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            
                    }
                    
                    Text(locations.year)
                    .font(.title3)
                    .fontWeight(.heavy)
                    
                }
                .padding(.bottom)
                Image(locations.image)
                .resizable()
                .scaledToFit()
                .padding()
                    .frame(width: 300, height: 300, alignment: .center)
                
             Spacer()

        .overlay(
            HStack {
                            Spacer()
                  
                    VStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "chevron.down.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        })
                        .padding(.trailing, 20)
                        .padding(.top, 40)
                    Spacer() }
            }
                    
   ) }
        }
    }

    
    
    }
    
    


struct ModalView: View {
    @Binding var presentedAsModal: Bool
    var body: some View {
        Button("dismiss") { self.presentedAsModal = false }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


