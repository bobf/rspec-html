# frozen_string_literal: true

RSpec.describe RSpecHTML::Element do
  subject(:element) { document }

  let(:document) { described_class.new(html, :document) }

  let(:html) { Nokogiri::HTML.parse(fixture(:html, :basic).read) }

  it { is_expected.to be_a described_class }
  its(:body) { is_expected.to be_a RSpecHTML::Element }
  its(:head) { is_expected.to be_a RSpecHTML::Element }

  describe '.reconstituted' do
    subject(:reconstituted) { described_class.reconstituted(tag, options) }
    context 'simple tag' do
      let(:tag) { :span }
      let(:options) { {} }
      it { is_expected.to eql '<span />' }
    end

    context 'tag with options' do
      let(:tag) { :span }
      let(:options) { { name: 'my-name', align: 'left' } }
      it { is_expected.to eql '<span name="my-name" align="left" />' }
    end

    context 'tag with classes' do
      let(:tag) { :span }
      let(:options) { { name: 'my-name', class: %w[my-class-1 my-class-2] } }
      it { is_expected.to eql '<span name="my-name" class="my-class-1 my-class-2" />' }
    end

    context 'tag with text' do
      let(:tag) { :span }
      let(:options) { { text: 'some text' } }
      it { is_expected.to eql '<span>some text</span>' }
    end
  end

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

  describe 'traversal by text' do
    subject { element.body.span(text: text) }
    context 'expected text exists' do
      let(:text) { 'some example body content' }
      it { is_expected.to be_present }
    end

    context 'expected does not text exist' do
      let(:text) { 'some example missing content' }
      it { is_expected.to_not be_present }
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
