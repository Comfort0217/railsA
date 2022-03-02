puts 'start create users ...'
users = FactoryBot.create_list(:user, 10)
puts 'finish create users ...'

puts 'start create posts ...'
posts = 30.times.map { FactoryBot.create(:post, user: users.sample) }
puts 'finish create posts ...'

puts 'start create comments ...'
posts.each do |post|
  5.times.each { FactoryBot.create(:comment, user: users.sample, post: post) }
end
puts 'finish create comments ...'
