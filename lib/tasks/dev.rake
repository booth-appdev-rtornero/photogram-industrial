task sample_data: :environment do
  p "Creating sample data"

  if Rails.env.development?
    Like.destroy_all #destroy children objects first
    Comment.destroy_all #destroy children objects first
    FollowRequest.destroy_all #destroy children objects first
    Photo.destroy_all #destroy children objects first
    User.destroy_all
  end

  usernames = Array.new{ Faker::Name.first_name }

  usernames << "alice"
  usernames << "bob"
  usernames << "rai"
  usernames << "raghu"
  
  usernames.each do |username|
    User.create(
      email: "#{username}@example.com",
      password: "password",
      username: username.downcase,
      private: [true, false].sample
    )
  end
  p "#{User.count} users have been created."

  users = User.all

  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample #with enum we get this shortcut to get all possible values
        )
      end
    end
  end

  p "#{FollowRequest.count} follow requests have been created."

  users.each do |user|
    rand(20).times do 
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: "https://robohash.org/#{rand(9999)}"
      )

      user.followers.each do |follower|
        if rand < 0.5
          photo.fans << follower # pushing into the fans collection of the photo created. Unique use of the shovel operator
        end

        if rand < 0.4
          photo.comments.create(
            body: Faker::Quote.jack_handey,
            author: follower
          )
        end
      end

    end
  end

  ending = Time.now
  p "#{Photo.count} photos have been created."
  p "#{Like.count} likes have been created."
  p "#{Comment.count} comments have been created."

end
