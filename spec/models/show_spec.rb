RSpec.describe Show, type: :model do
  let(:bad_show) { FactoryGirl.build :show, venue_id: nil}
  let(:show) { FactoryGirl.build :show}

  describe 'validations' do
    it { is_expected.to validate_presence_of :start }
    describe 'validates_associated :venue' do
      it 'in invalid without an associated venue' do
        expect(bad_show).to_not be_valid
      end
      it 'is valid with an associated venue' do
        expect(show).to be_valid
      end
    end
  end
end
