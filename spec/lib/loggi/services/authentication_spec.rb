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
end
