# frozen_string_literal: true

RSpec.describe Loggi::Exceptions::ServiceException, type: :model do
  describe '.new' do
    subject { described_class.new('Error') }

    it 'provides a message attribute' do
      expect(subject.message).to eq('Error')
    end

    it 'provides a details attribute' do
      expect(subject.details).to be_nil
    end

    context 'when details is passed' do
      subject { described_class.new('Error', details) }
      let(:details) { { request: '' }.to_json }

      it 'provides a details attribute' do
        expect(subject.details).to eq(details)
      end
    end
  end
end
