require 'rails_helper'

RSpec.describe PreferredDaysController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:put_update) {
    put :update, params: {
      "utf8"=>"✓",
      "authenticity_token"=>"3nKsSgdlEbfRCCupxJhK3QQBhQiDYNX/QctuI3iVSHZw0cp6ljQHPkl15exz5BtZQeMGLbMzSZirGsN8wLg8Aw==",
      "preferred_day"=>{
        "preferred"=>"true"
      },
      "user_id"=>user.id,
      "id"=>user.preferred_days[0].id}
  }
  describe '#update' do
    before(:each) do
      sign_in user
    end
    it 'updates a preferred_day in the database' do
      put_update
      expect(User.find(user.id).preferred_days[0].preferred).to eq(true)
    end

    it 'renders the _day_form template' do
      expect(put_update).to render_template('preferred_days/_day_form')
    end

    it 'responds with a status of 200' do
      put_update
      expect(response.status).to eq(200)
    end
  end

end
