require_relative '../11/octapus.rb'
require 'byebug'

RSpec.describe Octapus do

  it 'increases all energy levels' do
    octapus = described_class.new([
      [1, 2, 3, 4],
      [5, 6, 3, 1],
    ])

    octapus.tick
    expect(octapus.energy).to eq([
      [2, 3, 4, 5],
      [6, 7, 4, 2],
    ])
  end

  it 'flashes and causes other surrounding energy levels to rise' do
    octapus = described_class.new([
      [1, 1, 1, 1, 1],
      [1, 9, 9, 9, 1],
      [1, 9, 1, 9, 1],
      [1, 9, 9, 9, 1],
      [1, 1, 1, 1, 1],
    ])

    octapus.tick
    expect(octapus.energy).to eq([
      [3,4,5,4,3],
      [4,0,0,0,4],
      [5,0,0,0,5],
      [4,0,0,0,4],
      [3,4,5,4,3],
    ])

    octapus.tick
    expect(octapus.energy).to eq([
      [4, 5, 6, 5, 4],
      [5, 1, 1, 1, 5],
      [6, 1, 1, 1, 6],
      [5, 1, 1, 1, 5],
      [4, 5, 6, 5, 4],
    ])
  end
end