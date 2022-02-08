require 'rails_helper'

RSpec.describe Cat, type: :model do
    it "should validate name, age, enjoys, and image to be populated" do
        cat = Cat.create
        expect(cat.errors[:name]).to_not be_empty
        expect(cat.errors[:age]).to_not be_empty
        expect(cat.errors[:enjoys]).to_not be_empty
        expect(cat.errors[:image]).to_not be_empty
    end
    it "validates enjoys to be at least 10 characters" do
        cat = Cat.create(enjoys:"123456789")
        expect(cat.errors[:enjoys]).to_not be_empty
    end
end
