# frozen_string_literal: true

RSpec.describe Loggi::DriverPosition, type: :model do
  describe '#initialize' do
    subject { described_class.new(options) }

    context 'without options' do
      let(:options) { {} }

      it 'shouldnt full any field' do
        expect(subject.lat).to be_nil
        expect(subject.lng).to be_nil
        expect(subject.current_waypoint_index).to be_nil
        expect(subject.current_waypoint_index_display).to be_nil
      end
    end

    context 'with options' do
      let(:options) do
        {
          lat: -23.54532882509319,
          lng: -46.59718813284402,
          current_waypoint_index: 0,
          current_waypoint_index_display: 'A'
        }
      end

      it 'should full all fields' do
        expect(subject.lat).to eq(-23.54532882509319)
        expect(subject.lng).to eq(-46.59718813284402)
        expect(subject.current_waypoint_index).to eq(0)
        expect(subject.current_waypoint_index_display).to eq('A')
      end
    end
  end
end
