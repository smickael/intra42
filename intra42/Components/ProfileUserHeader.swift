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
    let location: String?
    let campus: [Campus]?
    
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
            if let activeCampus = campus?.first(where: { $0.active }) {
                CountryFlag(countryName: activeCampus.country, city: activeCampus.city)
            }
            if (location != nil) {
                Text(location ?? "away")
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
                    .foregroundStyle(.white)
                    .background(.red)
                    .cornerRadius(6)
                    .font(.system(size: 10))
                    .fontWeight(.semibold)
                    .textCase(.uppercase)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.red, lineWidth: 2)
                    )
            }
        }
    }
}

#Preview {
    ProfileUserHeader(usualFullName: "Karim Coulibaly", login: "kacoulib", imageURL: nil, location: "bess-f1r4s2", campus: [
        Campus(id: 7, name: "Fremont", timeZone: "America/Tijuana", language: Language(id: 2, name: .english, identifier: .en, createdAt: "2015-04-14T16:07:38.122Z", updatedAt: "2024-06-06T11:02:03.910Z"), usersCount: 18213, vogsphereID: 2, country: "United States", address: "6 600 Dumbarton Circle", zip: "94555", city: "Fremont", website: "https://www.42.us.org/", facebook: "https://www.42.us.org/", twitter: "https://www.42.us.org/", active: false, campusPublic: false, emailExtension: "42.us.org", defaultHiddenPhone: false),
        Campus(id: 1, name: "Paris", timeZone: "Europe/Paris", language: Language(id: 1, name: .français, identifier: .fr, createdAt: "2014-11-02T16:43:38.466Z", updatedAt: "2024-06-28T13:57:38.544Z"), usersCount: 30502, vogsphereID: 1, country: "France", address: "96, boulevard Bessières", zip: "75017", city: "Paris", website: "https://www.42.fr/", facebook: "https://www.42.fr/", twitter: "https://www.42.fr/", active: true, campusPublic: true, emailExtension: "42.fr", defaultHiddenPhone: false)
    ])
}
