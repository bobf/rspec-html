# frozen_string_literal: true

RSpec.describe RSpecHTML::Document do
  subject(:document) { described_class.new(html) }

  let(:html) { fixture(:html, :basic).read }

  it { is_expected.to be_a described_class }
  its(:body) { is_expected.to be_a RSpecHTML::Body }
  its(:head) { is_expected.to be_a RSpecHTML::Head }
end
