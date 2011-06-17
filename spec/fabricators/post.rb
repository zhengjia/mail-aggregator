Fabricator(:post) do
  date { Fabricate.sequence(:date) { |i| Date.today - i } }
  subject Faker::Lorem.sentence
  body Faker::Lorem.sentences
end