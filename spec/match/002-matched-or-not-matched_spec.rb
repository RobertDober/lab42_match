RSpec.describe Lab42::Match do
  let(:rgx) { %r{(\d+)\.(\d+)} }
  subject { described_class.new( rgx, "" ) }

  context "matched, but not a match" do
    it "is matched" do
      expect( subject ).to be_matched
    end

    it "is however not successful" do
      expect( subject ).not_to be_success
    end
  end

  context "Vain attempts of cleverness" do
    it "to change something" do
      expect{ subject.replace(1, "") }.to raise_error(described_class::UnsuccessfulMerge)
    end
  end
end
