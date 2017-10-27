require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to have_many :venues }
  it { is_expected.to have_many :users }
  it { is_expected.to have_many :shows }
end
