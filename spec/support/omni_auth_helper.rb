module OmniAuthHelper
  def github_mock(uid, nickname)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      provider: 'github',
      uid: uid,
      info: { nickname: nickname },
      credentials: { token: 'hogehoge' }
    )
  end
end
