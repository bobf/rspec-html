# frozen_string_literal: true

RSpec.describe RSpecHTML::Element do
  subject(:element) { described_class.new(html, :document) }

  let(:html) { Nokogiri::HTML.parse(fixture(:html, :basic).read) }

  it { is_expected.to be_a described_class }
  its(:body) { is_expected.to be_a RSpecHTML::Element }
  its(:head) { is_expected.to be_a RSpecHTML::Element }

  describe 'recursive tag traversal' do
    subject { element.body.span }
    its(:to_s) { is_expected.to eql 'some example body content' }
  end

  describe 'attribute retrieval' do
    subject { element.body.span[:class] }
    it { is_expected.to eql 'example-class' }
  end

  describe 'attribute matching' do
    subject { element.body.span(class: 'another-class')['data-value'] }
    it { is_expected.to eql 'a data value' }
  end

  describe '#has_css?' do
    subject(:has_css?) { element.has_css?(match) }

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
    subject(:has_xpath?) { element.has_xpath?(match) }

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
