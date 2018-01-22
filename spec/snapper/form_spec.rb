RSpec.describe Snapper::Form do
  class TestModel
    attr_accessor :name, :email, :address
  end

  class TestForm < described_class
    field :name
    field :email

    validation do
      required(:name).filled
    end
  end

  it "remember fields" do
    expect(TestForm.fields).to eq [:name, :email]
  end

end
