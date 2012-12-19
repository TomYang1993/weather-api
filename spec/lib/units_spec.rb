require 'spec_helper'

describe Weather::Units do
  let(:client) { Weather::API.new }

  describe 'constants' do
    it 'should have constants for celsius and farenheit' do
      expect(Weather::Units::FARENHEIT).to eq 'f'
      expect(Weather::Units::CELSIUS).to eq 'c'
    end
  end

  describe 'defaults' do
    use_vcr_cassette

    it 'should default to imperial units' do
      response = client.lookup(9848)

      expect(response.units.distance).to    eq 'mi'
      expect(response.units.pressure).to    eq 'in'
      expect(response.units.speed).to       eq 'mph'
      expect(response.units.temperature).to eq 'F'
    end

    it 'should switch to metric if specified' do
      response = client.lookup(9848, 'c')

      expect(response.units.distance).to    eq 'km'
      expect(response.units.pressure).to    eq 'mb'
      expect(response.units.speed).to       eq 'km/h'
      expect(response.units.temperature).to eq 'C'
    end
  end
end
