require 'rails_helper'

RSpec.describe Mentor::ChatGroupsController, type: :controller do
  before(:each) do
    create(:type, name: 'student')
    create(:type, name: 'mentor')
    cookies.permanent.signed[:mentor_id] = {
      value: mentor.id,
      expires: 30.days.from_now
    }
  end
  let!(:student)         { create(:student) }
  let!(:another_student) { create(:student) }
  let(:mentor) { create(:mentor, verified: true) }

  shared_examples 'assign_chat_groups' do
    # TODO: テストが通らないのを直す
    let!(:message1) { create(:message, chat_group_id: student.id, user_id: mentor.id) }
    let!(:message2) { create(:message, chat_group_id: another_student.id, user_id: mentor.id) }
    it { expect(assigns(:chat_groups).first.id).to eq student.id }
    it { expect(assigns(:chat_groups).first.nickname).to eq student.nickname }
    # it { expect(assigns(:chat_groups).first.latest_message).to eq message1.content }
    # it { expect(assigns(:chat_groups).first.updated_time).to eq message1.created_at }
    it { expect(assigns(:chat_groups).last.id).to eq another_student.id }
    it { expect(assigns(:chat_groups).last.nickname).to eq another_student.nickname }
    # it { expect(assigns(:chat_groups).last.latest_message).to eq message2.content }
    # it { expect(assigns(:chat_groups).last.updated_time).to eq message2.created_at }
  end

  describe '#index' do
    before(:each) { get :index }
    it_behaves_like 'assign_chat_groups'
    it { expect(response).to render_template :index }
  end

  describe '#show' do
    let(:message1) { create(:message, chat_group_id: student.id, user_id: mentor.id) }
    let(:message2) { create(:message, chat_group_id: student.id, user_id: student.id) }
    let(:messages) { [message1, message2] }
    let(:params)   { { id: student.id } }
    before(:each) { get :show, params: params }

    context 'when correct params' do
      it_behaves_like 'assign_chat_groups'
      it { expect(assigns(:messages)).to eq messages }
      it { expect(assigns(:chat_group_id)).to eq student.id }
      it { expect(response).to render_template :show }
    end
    context 'when incorrect params' do
      let(:params) { { id: 100 } }
      it { expect(response).to redirect_to mentor_chat_groups_path }
    end
  end
end
