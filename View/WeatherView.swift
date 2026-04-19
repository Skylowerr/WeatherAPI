//
//  WeatherView.swift
//  WeatherAppAPI
//
//  Created by Emirhan Gökçe on 14.10.2025.
//

import SwiftUI

struct WeatherView: View {
    //MARK: STATE OLDUĞU İÇİN HATA VERİYORDU. STATEOBJECT YAPINCA DÜZELD
    @State private var vm = WeatherViewModel()
    @AppStorage("useFahrenheit") private var useFahrenheit = false
    //@AppStorage aslında kalıcı hafıza (persistent storage) görevi görüyor.
    //Yani uygulamayı kapatsan bile, ayar kaybolmuyor

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter city name", text: $vm.city)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                Button {
                    Task{
                        await vm.fetch()
                        //fetch fonksiyonu async olarak tanımlı olduğu için await demeliyiz
                    }
                } label: {
                    Label("Get Weather", systemImage: "cloud.sun.fill")
                    
                }
                .buttonStyle(.borderedProminent)
                .padding()
                .disabled(vm.city.count < 3) //MARK: Şehir adı 3ten azsa butona basamazsın.
                
                if vm.isLoading {
                    //MARK: Yüklenirken çark döndürüyor
                    
                    ProgressView("Fetching Weather...")
                }else if let weather = vm.weather {
                    WeatherCard(
                        weather: weather,
                        useFahrenheit: useFahrenheit
                    )
                }
                //if vm.errorMessage != nil
                else{
                    ErrorMessageViews()
                }
                
                Spacer()

            }
            .navigationTitle("Weather App")
            .toolbar { //Sağ üstteki şey
                ToolbarItem{
                    //Çarka basınca açılacak yer
                    Menu {
                        Toggle(isOn: $useFahrenheit){
                            Label(useFahrenheit ? "Use Fahrenheit" : "Use Celsius", systemImage: "thermometer.sun")
                        }
                    } label: { //Sağ üstte görünecek çark
                        Image(systemName: "gear")
                    }

                }
            }

        }
    }
}

#Preview {
    WeatherView()
}
