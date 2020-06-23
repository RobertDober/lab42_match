RSpec.describe Lab42::Match do
  describe "index error on match w/o captures" do
    subject{ described_class.new(%r{.*}) }
    it "shall match any string" do
      expect( subject.match("alpha").string ).to eq("alpha")
    end
    it "even an empty one" do
      expect( subject.match("").parts ).to eq(["", "", ""])
    end
  end

  describe "one group" do
    subject{ described_class.new(%r{(.*)}) }
    it "shall match any string" do
      expect( subject.match("alpha").string ).to eq("alpha")
    end
    it "even an empty one" do
      expect( subject.match("alpha").parts ).to eq(["", "", "alpha", "", ""])
    end
    it "observation on empty captures" do
      expect( subject.match("").parts ).to eq(["", "", "", "", ""])
    end
  end
end
