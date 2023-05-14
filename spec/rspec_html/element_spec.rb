# frozen_string_literal: true

RSpec.describe RSpecHTML::Element do # rubocop:disable RSpec/FilePath
  subject(:element) { document }

  let(:document) { described_class.new(html, :document) }

  let(:html) { Nokogiri::HTML.parse(fixture(:html, :basic).read) }

  it { is_expected.to be_a described_class }
  its(:body) { is_expected.to be_a described_class }
  its(:head) { is_expected.to be_a described_class }

  describe '.reconstituted' do
    subject(:reconstituted) { described_class.reconstituted(tag, options) }

    context 'with simple tag' do
      let(:tag) { :span }
      let(:options) { {} }

      it { is_expected.to eql '<span />' }
    end

    context 'with tag with options' do
      let(:tag) { :span }
      let(:options) { { name: 'my-name', align: 'left' } }

      it { is_expected.to eql '<span name="my-name" align="left" />' }
    end

    context 'with tag with classes' do
      let(:tag) { :span }
      let(:options) { { name: 'my-name', class: %w[my-class-1 my-class-2] } }

      it { is_expected.to eql '<span name="my-name" class="my-class-1 my-class-2" />' }
    end

    context 'with tag with text' do
      let(:tag) { :span }
      let(:options) { { text: 'some text' } }

      it { is_expected.to eql '<span>some text</span>' }
    end

    context 'with tag with string css selector' do
      let(:tag) { :span }
      let(:options) { '#id.class1.class2' }

      it { is_expected.to eql '<span id="id" class="class1 class2" />' }
    end
  end

  describe 'recursive tag traversal' do
    subject { element.body.span }

    its(:text) { is_expected.to eql 'some example body content' }
  end

  describe 'traversal by attribute' do
    subject { element.body.span(align: 'center') }

    its([:class]) { is_expected.to eql 'another-class' }
  end

  describe 'class matching' do
    subject { element.body.div(class: 'class1') }

    its(['data-value']) { is_expected.to eql 'multi-class' }

    context 'with with other query options' do
      subject { element.body.div(class: 'class1', align: 'left') }

      its(['data-value']) { is_expected.to eql 'left-aligned multi-class' }
    end

    context 'with multiple classes' do
      subject { element.body.div(class: %w[class1 class2]) }

      its(['data-value']) { is_expected.to eql 'multi-class' }
    end
  end

  describe 'traversal by css selector string' do
    subject { element.body.span(selector) }

    context 'when expected element exists' do
      let(:selector) { '#example-id.example-class1.example-class2' }

      it { is_expected.to be_present }
    end

    context 'when expected element does not exist' do
      let(:selector) { '#example-id.example-class1.missing-class' }

      it { is_expected.not_to be_present }
    end
  end

  describe 'traversal by text' do
    subject { element.body.span(text: text) }

    context 'when expected text exists' do
      let(:text) { 'some example body content' }

      it { is_expected.to be_present }
    end

    context 'when expected text does not exist' do
      let(:text) { 'some example missing content' }

      it { is_expected.not_to be_present }
    end
  end

  describe 'attribute retrieval' do
    subject { element.body.span[:class] }

    it { is_expected.to eql 'example-class' }

    context 'with matching siblings' do
      subject { element.table.td('.table-cell').third.a }

      its([:href]) { is_expected.to eql 'http://example.com/' }
    end
  end

  describe '#all' do
    subject(:result) { document.span.all }

    it { is_expected.to be_all(described_class) }
    its(:size) { is_expected.to be 3 }

    context 'with matching elements outside of provided scope' do
      subject(:result) { document.form('.example-form').input(type: 'text').all }

      let(:html) { Nokogiri::HTML.parse(fixture(:html, :form_elements_in_different_scopes).read) }

      its(:size) { is_expected.to be 2 }

      it 'includes exactly the correct elements' do
        expect(result.map { |element| element[:name] }).to eql %w[foo bar]
      end
    end
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

    its(:size) { is_expected.to be 2 }
    it { is_expected.to all(be_a described_class) }
  end

  describe '#size' do
    subject { element.body.span.size }

    it { is_expected.to be 3 }
  end

  describe '#attributes' do
    subject { element.body.input.attributes }

    it { is_expected.to eql({ name: 'example', type: 'checkbox', checked: 'checked' }) }
  end

  it { is_expected.to exist }

  describe '#present?' do
    subject { element.present? }

    context 'when element found' do
      let(:element) { document.div }

      it { is_expected.to be true }
    end

    context 'when element not found' do
      let(:element) { document.section }

      it { is_expected.to be false }
    end
  end

  describe '#checked' do
    subject(:checked) { element.checked? }

    context 'when checked' do
      let(:element) { document.input(type: 'checkbox', checked: 'checked') }

      it { is_expected.to be true }
    end

    context 'when not checked' do
      let(:element) { document.input(type: 'checkbox') }

      it { is_expected.to be true }
    end
  end

  describe '#has_css?' do
    subject(:has_css?) { element.has_css?(match) }

    context 'with present css' do
      let(:match) { 'html body span.example-class' }

      it { is_expected.to be true }
    end

    context 'with absent css' do
      let(:match) { 'html body span.nonexistent-class' }

      it { is_expected.to be false }
    end
  end

  describe '#has_xpath?' do
    subject(:has_xpath?) { element.has_xpath?(match) }

    context 'with present xpath' do
      let(:match) { '//html/body/span[@class="example-class"]' }

      it { is_expected.to be true }
    end

    context 'with absent xpath' do
      let(:match) { '//html/body/span[@class="nonexistent-class"]' }

      it { is_expected.to be false }
    end
  end

  %i[first last second third fourth fifth].each do |method|
    describe "##{method}" do
      subject(method) { element.label.public_send(method) }

      its([:id]) { is_expected.to eql "label-#{method}" }
    end
  end

  describe '#css' do
    subject(:css) { element.css('.body.span') }

    it { is_expected.to be_a RSpecHTML::Search }
  end

  describe '#xpath' do
    subject(:css) { element.xpath('//html/body/span') }

    it { is_expected.to be_a RSpecHTML::Search }
  end
end
