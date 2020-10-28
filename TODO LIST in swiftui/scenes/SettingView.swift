//
//  SettingView.swift
//  TODO LIST in swiftui
//
//  Created by hosam on 10/27/20.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var iconsSettings:IconsNames
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            
            VStack(alignment: .center, spacing: 0){
                
                Form{
                    
                    Section(header: Text("Choose the app Icon")) {
                        Picker(selection: $iconsSettings.currentIndex, label:
                                
                                HStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .strokeBorder(Color.primary,lineWidth:2)
                                        Image(systemName:"paintbrush")
                                            .font(.system(size:28,weight:.regular,design:.default))
                                            .foregroundColor(Color.primary)
                                    }
                                    .frame(width:44,height:44)
                                    
                                    Text("App Icons")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.primary)
                                }
                               
                               
                               
                               , content: /*@START_MENU_TOKEN@*/{
                                ForEach(0..<iconsSettings.iconNames.count) {index in
                                   
                                    HStack {
                                        Image(uiImage: UIImage(named: self.iconsSettings.iconNames[index] ) ?? UIImage())
                                            .renderingMode(.original)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:44,height:44)
                                            .cornerRadius(8)
                                        
                                        Spacer()
                                            .frame(width:8)
                                        
                                        Text(self.iconsSettings.iconNames[index] )
                                            .frame(alignment:.leading)
                                    }
                                    .padding(3)
                                }
                               }/*@END_MENU_TOKEN@*/)
                            .onReceive([self.iconsSettings.currentIndex].publisher.first(), perform: { value in
                                let index = self.iconsSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName ?? "Blue Light"  ) ?? 0
                                
                                if index != value {
                                    UIApplication.shared.setAlternateIconName(iconsSettings.iconNames[value]) { (error) in
                                        if let err = error {
                                            print(err.localizedDescription)
                                        }else {
                                            print("success you have changed the app icon")
                                        }
                                    }
                                }
                            })
                    }
                    .padding(.vertical,3)
                    
                    Section(header: Text("Follow us on social media")){
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "Facebook", link: "https://www.facebook.com/hosammohamedasd/")
                        
                        FormRowLinkView(icon: "globe", color: Color.blue, text: "Linkedin", link: "https://www.linkedin.com/in/hosam-mohamed-425a83119/")
                        FormRowLinkView(icon: "globe", color: Color.blue, text: "Github", link: "https://github.com/hosamasd?tab=repositories")
                        FormRowLinkView(icon: "play.rectangle", color: Color.green, text: "Appstore", link: "https://apps.apple.com/us/developer/hosam-mohamed/id1482369833")
                    }
                    .padding(.vertical,3)
                    
                    Section(header: Text("About the APP")){
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone,iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Hosam")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Hosam")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    }
                    .padding(.vertical,3)
                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                Text("Copyright all right reserved.\n hosam mohamed ")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top,6)
                    .padding(.bottom,8)
                    .foregroundColor(Color.secondary)
            }
            .navigationBarTitle("Settings",displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image(systemName: "xmark")
                                    })
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environmentObject(IconsNames())
    }
}
