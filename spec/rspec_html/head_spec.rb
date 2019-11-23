# frozen_string_literal: true

RSpec.describe RSpecHTML::Head do
  subject(:entity) { described_class.new(html) }

  let(:html) { Nokogiri::HTML(fixture(:html, :basic).read) }

  it { is_expected.to be_a described_class }
  it_behaves_like 'nameable'
  its(:title) { is_expected.to be_a RSpecHTML::Title }

  describe '#include?' do
    it 'includes title text' do
      expect(entity.include?(I18n.t('test.basic.title'))).to be true
    end
  end
end
