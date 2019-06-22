# frozen_string_literal: true

RSpec.describe Loggi::Services::Base, type: :model do
  describe '#initialize' do
    subject { described_class.new(credential) }

    context 'without credential' do
      let(:credential) { nil }

      it 'shouldnt have a valid credential' do
        expect(subject.credential).to be_a(Loggi::Credential)
        expect(subject.credential.email).to be_nil
        expect(subject.credential.api_key).to be_nil
        expect(subject.credential.password).to be_nil
      end
    end

    context 'with credential' do
      let(:credential) { build :credential }

      it 'should have a credential' do
        expect(subject.credential).not_to be_nil
      end
    end
  end

  describe '#query' do
    subject { described_class.new(credential).query }

    let(:credential) { build :credential }

    it 'should raise NotImplementedError' do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end

  describe '#request!' do
    subject { instance.request! }

    let(:instance) { Loggi::Services::Authentication.new(credential) }
    let(:credential) { build :credential }

    describe 'headers' do
      context 'with authenticated resource' do
        before { allow(instance).to receive(:login_required?).and_return(true) }

        it 'should use authenticated header', :vcr do
          expect(instance).to receive(:authenticated_header).once.and_call_original
        end
      end

      context 'without authenticated resource' do
        before { allow(instance).to receive(:login_required?).and_return(false) }

        it 'should use default header', :vcr do
          expect(instance).to receive(:default_header).once.and_call_original
        end
      end

      after { subject }
    end
  end
end
