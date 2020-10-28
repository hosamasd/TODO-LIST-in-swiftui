//
//  FormRowStaticView.swift
//  TODO LIST in swiftui
//
//  Created by hosam on 10/27/20.
//

import SwiftUI

struct FormRowStaticView: View {
    
    var icon:String
    var firstText:String
    var secondText:String
    
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray)
                Image(systemName: icon)
                    .foregroundColor(Color.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(firstText).foregroundColor(Color.gray)
            Spacer()
            Text(secondText)
        }
    }
}

struct FormRowStaticView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
    }
}
