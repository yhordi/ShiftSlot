require 'rails_helper'

RSpec.describe Shift, type: :model do
  let(:bad_shift_no_show) { FactoryGirl.build :shift, show_id: nil}
  let(:shift) { FactoryGirl.build :shift}
  describe 'validates_associated :show' do
    xit 'in invalid without an associated show' do
      expect(bad_shift_no_show).to_not be_valid
    end
    xit 'is valid with an associated show' do
      expect(shift).to be_valid
    end
  end
end
