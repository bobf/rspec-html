# frozen_string_literal: true

RSpec.shared_examples 'searchable' do
  describe '#include?' do
    subject(:include?) { entity.include?(val) }

    context 'text exists in entity' do
      let(:val) { I18n.t("test.basic.#{entity.name}") }
      it { is_expected.to be true }
    end

    context 'text exists in mark-up' do
      let(:val) { I18n.t('test.basic.data') }
      it { is_expected.to be false }
    end

    context 'text does not exist anywhere' do
      let(:val) { I18n.t('test.basic.nonexistent') }
      it { is_expected.to be false }
    end
  end
end
