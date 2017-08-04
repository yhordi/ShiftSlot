require 'rails_helper'

RSpec.describe ShiftsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:job) { FactoryGirl.create(:job) }
  let(:venue) { FactoryGirl.create(:venue) }
  let(:show) { FactoryGirl.create(:show, venue_id: venue.id) }
  describe '#new' do
    let(:hit_show) { get :new, params: {show_id: show.id} }
    before(:each) do
      sign_in user
    end
    it 'responds with a status of 200' do
      hit_show
      expect(response.status).to eq(200)
    end
    it 'assigns the @jobs variable' do
      show.venue.jobs << job
      job.save
      hit_show
      expect(assigns(:jobs)).to include(job)
    end
    it 'assigns the @show variable' do
      hit_show
      expect(assigns(:show)).to eq(show)
    end
    it 'renders the _search_field template' do
      expect(hit_show).to render_template('_search_field')
    end
  end

  describe '#index' do
  end

  describe '#create' do
    before(:each) do
      sign_in user
    end
    let(:post_shift) { post :create, params:
      {"utf8"=>"✓",
      "authenticity_token"=>"xeGssQrlK3sj1lV+VrAT6ysq321yNZ5tBCJi+rohawn1Kv+9Bs/Uq6QYH5rLHtOVolDqwl/lZnpD7A1GUfKuhg==",
      "user_id"=>user.id,
      "job_id"=>job.id,
      "commit"=>"Schedule Worker",
      "controller"=>"shifts",
      "action"=>"create",
      "show_id"=>show.id}
      }
      it 'saves a shift to the database' do
        expect{post_shift}.to change{Shift.all.count}.by(1)
      end
      it 'responds with the newly created shift as a partial' do
        expect(post_shift).to render_template('shifts/_index')
      end
      it 'responds with a status of 200' do
        post_shift
        expect(response.status).to eq(200)
      end
  end
end
