require 'random_data'

15.times do
  Topic.create!(
    name:         RandomData.random_sentence,
    description:  RandomData.random_paragraph
  )
end
topics = Topic.all

#(number).times will allow code to run as many times as the number
50.times do
  #having ! after a method, would instruct the method
  #to raise a problem with the data we're seeding.
  Post.create!(
    # RandomData method will be created by ourself to create
    # random strings for title and body. This is known as "wishful coding"
    # this allow us to stay focused on one problem at a time.
    topic:  topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph

  )
end

15.times do
  SponsoredPost.create!(
    topic:  topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: RandomData.random_number  
  )
end

posts = Post.all

100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph

  )
end

10.times do
  Advertisement.create!(
    title: RandomData.random_sentence,
    copy: RandomData.random_paragraph,
    price: RandomData.random_number
  )
end

20.times do
  Question.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    resolved: false
  )
end


puts "Seed finished"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} ads created"
puts "#{Question.count} questions created"
