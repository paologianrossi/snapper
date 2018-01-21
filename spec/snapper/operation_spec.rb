RSpec.describe Snapper::Operation do
  class TestOp < described_class
    def params(left, right)
      @left, @right = left, right
    end

    def process
      if(@left > @right)
        result.difference = @left - @right
      end
    end
  end

  it "is callable" do
    expect(TestOp).to respond_to :call
  end

  context "when the codepath is ok" do
    it "is successful" do
      expect(TestOp.(5, 2)).to be_success
    end

    it "stores the result as expected" do
      expect(TestOp.(5, 2).difference).to eq 3
    end
  end

  context "when the codepath is bad" do
    it "is failure" do
      expect(TestOp.(2, 5)).to be_failure
    end
  end

  context "when setting an on_success override" do
    class TestOpSucc < TestOp
      def on_success(label)
        "#{label}: #{result.difference}"
      end
    end

    it "calls it when successful" do
      result = TestOpSucc.(5, 2)
      expect(result.("label")).to eq "label: 3"
    end

    it "does not call it when unsuccessful" do
      result = TestOpSucc.(2, 5)
      expect(result.("label")).to be_nil
    end
  end

  context "when setting an on_failure override" do
    class TestOpFail < TestOp
      def on_failure(label)
        "#{label}: ERROR"
      end
    end

    it "calls it when unsuccessful" do
      result = TestOpFail.(2, 5)
      expect(result.("label")).to eq "label: ERROR"
    end

    it "does not call it when successful" do
      result = TestOpFail.(5, 2)
      expect(result.("label")).to be_nil
    end
  end
end
