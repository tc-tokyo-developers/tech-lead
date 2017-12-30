FactoryBot.define do
  factory :mentor do
    type_id     :mentor
    provider    'github'
    uid         'foobar'
    github_name 'github_name_sample'
    nickname    nil
    profile     nil
    verified    false
  end
end
