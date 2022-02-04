require_relative '../1/incdec.rb'

it 'should equal an increase' do 
  num = increases([1, 2])
  expect(num).to eq(2)
end

it 'should equal an increase' do 
  num = increases([1, 2, 1, 5, 3])
  expect(num).to eq(3)
end