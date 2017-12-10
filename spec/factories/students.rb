FactoryBot.define do
  factory :student do
    type_id     :student
    provider    'github'
    uid         'foobar'
    github_name 'github_name_sample'
    nickname    nil
    profile     nil
    verified    false
  end
end
