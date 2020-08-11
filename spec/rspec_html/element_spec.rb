# frozen_string_literal: true

RSpec.describe RSpecHTML::Element do
  subject(:element) { document }

  let(:document) { described_class.new(html, :document) }

  let(:html) { Nokogiri::HTML.parse(fixture(:html, :basic).read) }

  it { is_expected.to be_a described_class }
  its(:body) { is_expected.to be_a RSpecHTML::Element }
  its(:head) { is_expected.to be_a RSpecHTML::Element }

  describe 'recursive tag traversal' do
    subject { element.body.span }
    its(:text) { is_expected.to eql 'some example body content' }
  end

  describe 'traversal by attribute' do
    subject { element.body.span(align: 'center') }
    its([:class]) { is_expected.to eql 'another-class' }

    describe 'class matching' do
      subject { element.body.div(class: 'class1') }
      its(['data-value']) { is_expected.to eql 'multi-class' }

      context 'with other query options' do
        subject { element.body.div(class: 'class1', align: 'left') }
        its(['data-value']) { is_expected.to eql 'left-aligned multi-class' }
      end

      context 'multiple classes' do
        subject { element.body.div(class: %w[class1 class2]) }
        its(['data-value']) { is_expected.to eql 'multi-class' }
      end
    end
  end

  describe 'attribute retrieval' do
    subject { element.body.span[:class] }
    it { is_expected.to eql 'example-class' }
  end

  describe '["string"]' do
    subject { element.body.span(class: 'another-class')['data-value'] }
    it { is_expected.to eql 'a data value' }
  end

  describe '[:symbol]' do
    subject { element.body.span(class: 'another-class')[:align] }
    it { is_expected.to eql 'center' }
  end

  describe '#[index]' do
    subject { element.body.span[2][:class] }
    it { is_expected.to eql 'another-class' }

    it 'raises ArgumentError when attempting to match 1' do
      expect { element.body.span[0] }.to raise_error ArgumentError
    end
  end

  describe '#[Range]' do
    subject { element.body.span[1...2] }
    its(:size) { is_expected.to eql 2 }
  end

  describe '#size' do
    subject { element.body.span.size }
    it { is_expected.to eql 2 }
  end

  describe '#size' do
    subject { element.body.span.length }
    it { is_expected.to eql 2 }
  end

  it { is_expected.to exist }

  describe '#present?' do
    subject { element.present? }

    context 'element found' do
      let(:element) { document.div }
      it { is_expected.to be true }
    end

    context 'element not found' do
      let(:element) { document.section }
      it { is_expected.to be false }
    end
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
