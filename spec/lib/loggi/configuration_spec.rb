# frozen_string_literal: true

RSpec.describe Loggi::Configuration, type: :model do
  describe '#configure' do
    subject { described_class.configure!(credential) }

    context 'with a credential with email and apikey' do
      let(:credential) { build(:credential, api_key: '14651f0f-8888-4100-9ab7-cf4b2dffb31e') }

      after { subject }

      it 'shouldnt request to authenticate again' do
        expect(credential).not_to receive(:authenticate!)
      end
    end

    context 'with a crendential with email and password' do
      let(:credential) { build(:credential) }

      after { subject }

      it 'should request to authenticate' do
        expect(credential).to receive(:authenticate!).once
      end
    end

    context 'with a empty crendential' do
      let(:credential) { Loggi::Credential.new({}) }

      after { subject }

      it 'shouldnt request to authenticate' do
        expect(credential).not_to receive(:authenticate!)
      end
    end
  end
end
