require 'rails_helper'

RSpec.describe Play, type: :model do
  it { is_expected.to validate_presence_of :timer_value }
  it { is_expected.to belong_to :image }
end
