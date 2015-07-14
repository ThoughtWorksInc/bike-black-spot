require_relative '../spec_helper'

describe 'Category' do

  describe 'create' do
    it 'should save to db' do
      category = Category.create(name: 'category1Name')
      expect(category[:name]).to eq(Category.first[:name])
    end
    it 'should save a uuid' do
      category = Category.create(name: 'category1Name')
      expect(Category.first[:uuid]).to eql(category.uuid)
    end
  end

  describe 'validation' do
    it 'should fail if no name' do
      Category.create
      expect(Category.first).to be_nil
    end
  end
end
