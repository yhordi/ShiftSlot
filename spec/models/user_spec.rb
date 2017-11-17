require 'rails_helper'

RSpec.describe User, type: :model do
  let(:venue) { FactoryGirl.create :venue}
  let(:org) { FactoryGirl.create :organization, venues: [venue]}
  let(:user) {FactoryGirl.create :user, organizations: [org]}
  let(:admin) {FactoryGirl.create :user, organizations: [org]}
  let(:new_user) {FactoryGirl.build :user}
  let(:job) {FactoryGirl.create :job, venue: venue}
  let(:job2) {FactoryGirl.create :job, title: 'Hamster', venue: venue}
  let(:show) {FactoryGirl.create :show, start: DateTime.new(2001,1)}
  let(:show2) {FactoryGirl.create :show, start: DateTime.new(2001,1)}
  let(:shift) {FactoryGirl.create :shift, show_id: show2.id, user_id: user.id, job_id: job.id}

  # let!(:day) {FactoryGirl.create :preferred_day, user_id: user.id}
  describe 'validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_length_of(:name).is_at_least(3) }
    it 'is valid with a unique email' do
      expect(user).to be_valid
    end
    it 'is invalid without a unique email' do
      new_user.email = user.email
      expect(new_user).to_not be_valid
    end
  end

  describe 'associations' do
    it "has many organizations" do
      expect(user.organizations).to be_an(ActiveRecord::Relation)
    end
  end

  describe '#authorized?' do
    it 'returns true if the user is authorized for a job' do
      user.jobs << job
      expect(user.authorized?(job)).to eq(true)
    end
    it 'returns false if the user is not authorized for a job' do
      expect(user.authorized?(job)).to eq(false)
    end

  end

  describe '#adjust_jobs' do
    it 'authorizes a user for jobs based on a passed in array' do
      user.adjust_jobs([job.id.to_s])
      expect(user.jobs).to include(job)
    end
    it 'removes all associated jobs if passed nil' do
      user.adjust_jobs(nil)
      expect(user.jobs).to be_empty
    end
  end

  describe '#add_days' do
    it 'automatically sets up a user with seven preferred days after save' do
      new_user.save
      expect(new_user.preferred_days.length).to eq(7)
    end
  end

  describe '#admin?' do
    it 'responds true when the user is an admin of the current orgaization' do
      assignment = admin.assignments.find_by(user_id: admin.id)
      assignment.admin = true
      assignment.save
      expect(admin.admin?(org.id)).to be(true)
    end
    it 'responds false when the user is not an admin of the current organization' do
      expect(user.admin?(org.id)).to be(false)
    end
  end

  describe '#admin_for?' do
    before(:each) do
      admin.admin = org
    end
    it 'returns false when an admin is not associated with the same org as a user' do
      expect(admin.admin_for?(user)).to eq(true)
    end
    it 'returns false when a user is not an admin' do
      expect(user.admin_for?(user)).to eq(false)
    end
    it 'returns true when an admin is not associated with the same org as a user' do
      expect(admin.admin_for?(new_user)).to eq(false)
    end
  end

  describe '#revoke_admin' do
    before(:each) do
      admin.admin = org
      user.admin = org
    end
    it 'sets the admin field to false on an assignment belonging to a user' do
      user.revoke_admin(org)
      expect(user.admin?(org.id)).to eq(false)
    end
  end

  describe '#orgs_responsible_for' do
    it 'returns all the organiztions in common bewtween a user and an admin that the admin is in charge of' do
      admin.admin = org
      expect(admin.orgs_responsible_for(user)).to eq([org])
    end
  end

  describe '#available' do
    it 'returns true if the worker is not currently scheduled' do
      expect(user.available?(show)).to eq(true)
    end
    it 'returns true if the worker is willing to work the day of the week of the show' do
      user.preferred_days[1].preferred = true
      expect(user.available?(show)).to eq(true)
    end
    it 'returns false if the worker prefers to not work the day of the show' do
      user.preferred_days[1].preferred = false
      expect(user.available?(show)).to eq(false)
    end
    it 'returns false if the worker is scheduled to work on the day of the show' do
      user.jobs << job
      shift
      expect(user.available?(show)).to eq(false)
    end
  end

  describe '#authorized_venues' do
    it 'returns an array of venue objects associated with the jobs for the user' do
      user.jobs << job
      expect(user.authorized_venues).to eq([job.venue])
    end

    it 'returns an array with no duplicate venues' do
      user.jobs << job
      user.jobs << job2
      expect(user.authorized_venues).to eq([job.venue])
    end
  end

  describe '#venues' do
    let(:venue2) { FactoryGirl.create(:venue) }
    let(:org2) { FactoryGirl.create(:organization, venues: [venue]) }
    it 'returns a collection of venue objest that a user could work at, based on the organizations that they belong to' do
      user.organizations << org2
      # user.save

      expect(user.venues).to eq(org.venues)
    end
  end
end
