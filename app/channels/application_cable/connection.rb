module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user_id

    def connect
      self.current_user_id = user_id_from_cookies
    end

    private

    # cookiesからユーザー情報を取得するためにこのConnectionクラスを使う
    def user_id_from_cookies
      cookies.signed[:student_id] || cookies.signed[:mentor_id]
    end
  end
end
