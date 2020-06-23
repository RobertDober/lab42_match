RSpec.describe Lab42::Match do
  let(:rgx) { %r{(\d+)\.(\d+)} }
  let(:string) { "> 42.43 <" }

  subject { described_class.new( rgx, string) }

  context "what we got" do
    it "is successful match" do
      expect( subject ).to be_success
    end

    it "a match that corresponds to the rgx being matched" do
      expected = rgx.match(string)
      expect( subject.match ).to eq(expected)
    end

    it "has all the parts" do
      expect( subject.string ).to eq(string)
      expect( subject.groups ).to eq(%w[42 43])
    end
  end

  context "what we can do now" do
    describe "replacing a group" do
      let(:replaced) { subject.replace(1, "1") }

      it "does not modify subject" do
        expect( subject.string ).to eq(string)
      end
    end
  end
end
