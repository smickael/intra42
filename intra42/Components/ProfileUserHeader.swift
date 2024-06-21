//
//  ProfileUserHeader.swift
//  intra42
//
//  Created by Mickaël on 27/03/2024.
//

import SwiftUI

struct ProfileUserHeader: View {
    let usualFullName, login: String
    let imageURL: URL?
    
    var body: some View {
        HStack {
            if let imageURL = imageURL {
                // AsyncImage because we don't know if imageURL exists
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 52, height: 52)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 52, height: 52)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 52, height: 52)
            }
            
            VStack(alignment: .leading) {
                Text(usualFullName)
                    .font(.system(size: 20, weight: .bold))
                Text(login)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }.padding(.leading, 8)
            Spacer()
        }
    }
}

#Preview {
    ProfileUserHeader(usualFullName: "Karim Coulibaly", login: "kacoulib", imageURL: nil)
}
