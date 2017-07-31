RSpec.describe Show, type: :model do
  it { is_expected.to validate_presence_of :start }
end
