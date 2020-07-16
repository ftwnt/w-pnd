require 'rails_helper'

describe Plays::RetrievalService do
  subject { described_class.new(length: length, klass: klass).perform }

  context 'when wrong klass has been passed' do
    let(:length) { 5 }
    let(:klass) { double('SomeObject') }

    it { expect { subject }.to raise_error(NotImplementedError) }
  end

  context 'when correct klass has been passed' do
    let(:length) { 5 }
    let(:klass) { Image }

    context "and there's not enough records" do
      before { (length - 1).times { create(:image) } }

      it { expect(subject.count).to eq length }
    end

    context "and there's exact amount of records" do
      before { length.times { create(:image) } }

      it { expect(subject.count).to eq length }
    end

    context "and there's more than needed records" do
      before { (length + 1).times { create(:image) } }

      it { expect(subject.count).to eq length }
    end
  end
end
