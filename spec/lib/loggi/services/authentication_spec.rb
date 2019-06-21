# frozen_string_literal: true

RSpec.describe Loggi::Services::Authentication, type: :model do
  describe '#query' do
    subject { described_class.new(credential).query }

    let(:credential) { build :credential }
    let(:template) do
      <<-QUERY
        mutation {
          login(input: {
                email: "#{credential.email}",
                password: "#{credential.password}"
                }) {
            user {
              apiKey
            }
          }
        }
      QUERY
    end

    it 'should be equal as a template' do
      expect(subject.squish).to eq(template.squish)
    end
  end

  describe '#login_required?' do
    subject { described_class.new(nil).login_required? }

    it 'shouldnt be login required' do
      is_expected.to be_falsey
    end
  end

  describe '#request!' do
    subject { described_class.new(credential).request! }

    context 'without correct params' do
      let(:credential) { build :credential, password: '1234' }

      it 'shouldnt found an user', :vcr do
        expect(subject[:login][:user]).to be_nil
      end
    end

    context 'with correct params' do
      let(:credential) { build :credential }

      it 'should return an user api key', :vcr do
        expect(subject[:login][:user][:apiKey]).not_to be_nil
      end
    end
  end

  describe '#authenticate!' do
    subject { described_class.authenticate!(credential) }

    context 'without correct params' do
      let(:credential) { build :credential, password: '1234' }

      it 'should raise bad request HTTP error', :vcr do
        expect(credential.api_key).to be_nil
        expect { subject }.to raise_error(described_class::UserNotFoundError)
      end
    end

    context 'with correct params' do
      let(:credential) { build :credential }

      it 'should return an user api key', :vcr do
        expect(credential.api_key).to be_nil
        subject
        expect(credential.api_key).not_to be_nil
      end
    end
  end
end
