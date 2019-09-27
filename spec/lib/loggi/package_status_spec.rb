# frozen_string_literal: true

RSpec.describe Loggi::PackageStatus, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.status).to be_nil
        expect(subject.status_display).to be_nil
        expect(subject.detailed_status_display).to be_nil
        expect(subject.status_code).to be_nil
        expect(subject.updated).to be_nil
      end
    end

    context 'with options' do
      let(:options) do
        {
          status: 'ns',
          status_display: 'Não iniciada',
          detailed_status_display: 'Agendado',
          status_code: 1,
          updated: '2019-04-24 13:48:33.126401'
        }
      end

      it 'should full all fields' do
        expect(subject.status).to eq('ns')
        expect(subject.status_display).to eq('Não iniciada')
        expect(subject.detailed_status_display).to eq('Agendado')
        expect(subject.status_code).to eq(1)
        expect(subject.updated).to eq(ActiveSupport::TimeZone['America/Sao_Paulo'].parse('2019-04-24 13:48:33.126401'))
      end
    end
  end
end
