# frozen_string_literal: true

RSpec.describe Loggi::Credential, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.email).to be_nil
        expect(subject.password).to be_nil
        expect(subject.api_key).to be_nil
      end
    end

    context 'with options' do
      let(:email) { Faker::Internet.email }
      let(:password) { Faker::Internet.password }
      let(:api_key) { SecureRandom.uuid }
      let(:options) { { email: email, password: password, api_key: api_key } }

      it 'should full all fields' do
        expect(subject.email).to eq(email)
        expect(subject.password).to eq(password)
        expect(subject.api_key).to eq(api_key)
      end
    end
  end

  describe '#authenticate!' do
    subject { build(:credential).authenticate! }

    after { subject }

    it 'should call authentication service' do
      expect(Loggi::Services::Authentication).to receive(:authenticate!).once
    end
  end
end
