//
//  EmptyListView.swift
//  Todo App
//
//  Created by Naufal Gagambani Sumbi on 19/02/21.
//

import SwiftUI

struct EmptyListView: View {
    
    
    let image: [String] = [
        "illustration-no1",
        "illustration-no2",
        "illustration-no3"
    ]
    
    let tips : [String] = [
        "Gunakan waktumu dengan baik",
        "lambat dan mantap memenangkan  perlombaan",
        "Tetap ada untukmu",
        "Setiap malam jadwal untuk besok"
    ]
    var body: some View {
        ZStack{
            VStack {
                Image("\(image.randomElement() ?? self.image[0])")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .layoutPriority(1)
                
                Text("\(tips.randomElement() ?? self.tips[0])")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
            }
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(Color("ColorBase"))
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
