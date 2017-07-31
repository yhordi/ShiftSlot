require 'rails_helper'

RSpec.describe Venue, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :location }
  end
end
