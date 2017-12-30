FactoryBot.define do
  factory :user do
    type_id     %i[student mentor].sample
    provider    'github'
    uid         'foobar'
    github_name 'github_name_sample'
    nickname    nil
    profile     nil
    verified    false
  end
end
