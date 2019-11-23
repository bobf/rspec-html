# frozen_string_literal: true

RSpec.shared_examples 'nameable' do
  describe '#name' do
    subject(:name) { entity.name }
    it { is_expected.to be_a Symbol }
  end
end
