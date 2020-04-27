# frozen_string_literal: true

RSpec.describe RSpecHTML::Document do
  subject(:document) { described_class.new(html) }

  let(:html) { fixture(:html, :basic).read }

  it { is_expected.to be_a described_class }
  its(:body) { is_expected.to be_a RSpecHTML::Body }
  its(:head) { is_expected.to be_a RSpecHTML::Head }

  describe '#has_css?' do
    subject(:has_css?) { document.has_css?(match) }

    context 'present css' do
      let(:match) { 'html body span.example-class' }
      it { is_expected.to be true }
    end

    context 'absent css' do
      let(:match) { 'html body span.nonexistent-class' }
      it { is_expected.to be false }
    end
  end

  describe '#has_xpath?' do
    subject(:has_xpath?) { document.has_xpath?(match) }

    context 'present xpath' do
      let(:match) { '//html/body/span[@class="example-class"]' }
      it { is_expected.to be true }
    end

    context 'absent xpath' do
      let(:match) { '//html/body/span[@class="nonexistent-class"]' }
      it { is_expected.to be false }
    end
  end
end
