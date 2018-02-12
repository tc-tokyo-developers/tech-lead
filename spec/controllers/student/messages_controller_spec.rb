require 'rails_helper'

RSpec.describe Student::MessagesController, type: :controller do
  let(:student) { create(:student) }
  let(:mentor)  { create(:mentor) }
  before(:each) do
    create(:type, name: 'student')
    create(:type, name: 'mentor')
    cookies.permanent.signed[:student_id] = {
      value: student.id,
      expires: 30.days.from_now
    }
  end

  describe '#index' do
    let(:message1) { create(:message, chat_group_id: student.id, user_id: student.id) }
    let(:message2) { create(:message, chat_group_id: student.id, user_id: mentor.id) }
    let(:messages) { [message1, message2] }
    before(:each) { get :index }

    it { expect(assigns(:messages)).to eq messages }
    it { expect(assigns(:message)).to be_a_kind_of(Message) }
    it { expect(response).to render_template :index }
  end
end
