# frozen_string_literal: true

require 'faker'

# Reset database
User.destroy_all
Event.destroy_all
Artist.destroy_all
Venue.destroy_all
Workspace.destroy_all

# Users
users = User.create([
                      {
                        firstname: 'Christoph',
                        lastname: 'Wiedenmann',
                        email: 'christoph@ag-prop.com',
                        password: '12345678'
                      },
                      {
                        firstname: 'Fabian',
                        lastname: 'Wirths',
                        email: 'fabian@ag-prop.com',
                        password: '12345678'
                      },
                      {
                        firstname: 'Andre',
                        lastname: 'Rümpke',
                        email: 'andrem@ag-prop.com',
                        password: '12345678'
                      }
                    ])

2.times do
  workspace = Workspace.create({
                                 name: Faker::Company.name
                               })

  # Venues
  venues = []
  20.times do
    venues << Venue.create({
                             name: Faker::WorldCup.stadium,
                             capacity: rand(200..3000)
                           })
  end

  # Artists
  10.times do
    main_artist = Artist.create({
                                  name: Faker::Music::RockBand.name
                                })

    # Events
    events = []
    4.times do |index|
      event = Event.create({
                             name: "Tour 202#{index} - #{main_artist.name}",
                             date: Faker::Date.forward(days: 365),
                             guests: rand(10..100),
                             venue: venues.sample
                           })

      support_artists = []
      2.times do
        support_artists << Artist.create({
                                           name: Faker::Music::RockBand.name
                                         })
      end

      artists = support_artists << main_artist

      event.artists = artists
      workspace.artists << artists

      events << event
    end

    workspace.events << events
  end

  workspace.venues = venues
  workspace.users = users.sample(2)
end

