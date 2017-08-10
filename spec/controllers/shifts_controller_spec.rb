require 'rails_helper'

RSpec.describe ShiftsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:job) { FactoryGirl.create(:job) }
  let(:venue) { FactoryGirl.create(:venue) }
  let(:show) { FactoryGirl.create(:show, venue_id: venue.id) }
  let(:shift) { FactoryGirl.create(:shift, job_id: job.id, show_id: show.id, user_id: user.id)}
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
      expect(hit_show).to render_template("shifts/_new")
    end
  end

  describe '#edit' do
    let(:get_edit) { get :edit, params: {id: shift.id} }
    before(:each) do
      sign_in user
    end
    it 'assigns the @shift variable' do
      get_edit
      expect(assigns[:shift]).to eq(shift)
    end
    it 'assigns the @show variable' do
      get_edit
      expect(assigns[:show]).to eq(show)
    end
    it 'assigns the @jobs variable' do
      get_edit
      expect(assigns[:jobs]).to all(be_a(Job))
    end
    it 'renders the users/search_field template' do
      expect(get_edit).to render_template('users/_search_field')
    end
    it 'responds with a status of 200' do
      get_edit
      expect(response.status).to eq(200)
    end
  end

  describe '#update' do
    before(:each) do
      sign_in user
    end
    let(:shift_no_user) { FactoryGirl.create(:shift, job_id: job.id, show_id: show.id, user_id: nil) }
    let(:patch_params) {
      {"utf8"=>"✓",
        "_method"=>"patch",
        "authenticity_token"=>"QxAEn4qOdUace+klqMn8mu/cBLQgW3pPwfClc/GkgU/1bu5Be/laYo3m5h/utjCc1N82l9R/oL7UeZApDRSJyQ==",
        "user_id"=>user.id,
        "job_id"=>job.id,
        "commit"=>"Schedule Worker",
        "controller"=>"shifts",
        "action"=>"update",
        "id"=>shift_no_user.id
      }
    }
    let!(:patch_request) { patch :update, params: patch_params }

    it 'responds with a status of 200' do
      patch_request
      expect(response.status).to eq(200)
    end
    it 'updates a shift in the database' do
      patch_request
      expect(shift_no_user.reload.user.name).to eq(user.name)
    end
    it 'renders a template'
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

  describe '#destroy' do
    let(:hit_delete) { delete :destroy, params: {id: shift.id} }
    before(:each) do
      sign_in user
    end

    it 'responds with a status of 302' do
      hit_delete
      expect(response.status).to eq(302)
    end
    it 'deletes the shift from the database' do
      hit_delete
      expect{Shift.find(shift.id)}.to raise_error{ActiveRecord::RecordNotFound}
    end
  end
end
