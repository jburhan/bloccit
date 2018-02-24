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
# we call sample on the array returned by Post.all, in order to pick a random post
# to associate each comment with. sample returns a random element
post = Post.all

100.times do
  Comment.create!(
    post: post.sample,
    body: RandomData.random_paragraph

  )
end

puts "Seed finished"
puts "#{Post.count} post created"
puts "#{Comment.count} comments created"
