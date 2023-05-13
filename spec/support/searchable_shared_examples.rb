# frozen_string_literal: true

RSpec.shared_examples 'searchable' do
  describe '#include?' do
    subject(:include?) { entity.include?(val) }

    context 'when text exists in entity' do
      let(:val) { I18n.t("test.basic.#{entity.name}") }

      it { is_expected.to be true }
    end

    context 'when text exists in mark-up' do
      let(:val) { I18n.t('test.basic.data') }

      it { is_expected.to be false }
    end

    context 'when text does not exist anywhere' do
      let(:val) { I18n.t('test.basic.nonexistent') }

      it { is_expected.to be false }
    end
  end

  describe '#to_s' do
    subject(:to_s) { entity.to_s }

    it { is_expected.to eql I18n.t("test.basic.#{entity.name}") }
  end

  describe '#inspect' do
    subject(:inspect) { entity.inspect }

    it { is_expected.to eql %("#{I18n.t("test.basic.#{entity.name}")}") }
  end
end
