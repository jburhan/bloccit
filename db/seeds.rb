require 'random_data'

#(number).times will allow code to run as many times as the number
50.times do
  #having ! after a method, would instruct the method
  #to raise a problem with the data we're seeding.
  Post.create!(
    # RandomData method will be created by ourself to create
    # random strings for title and body. This is known as "wishful coding"
    # this allow us to stay focused on one problem at a time.
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph

  )
end

Post.find_or_create_by!(
  id: 12345,
  title: "Why is the sky blue?",
  body: "Blue light is scattered in all directions by the tiny molecules of air in Earth's atmosphere.
  Blue is scattered more than other colors because it travels as shorter, smaller waves.
  This is why we see a blue sky most of the time. ...
  Also, the surface of Earth has reflected and scattered the light."
)
# we call sample on the array returned by Post.all, in order to pick a random post
# to associate each comment with. sample returns a random element
posts = Post.all

100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph

  )
end

Comment.find_or_create_by!(
  post: Post.find(12345),
  body: "Thanks for the informations!"
)

puts "Seed finished"
puts "#{Post.count} post created"
puts "#{Comment.count} comments created"
