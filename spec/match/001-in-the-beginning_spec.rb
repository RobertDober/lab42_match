RSpec.describe Lab42::Match do
  let(:rgx) { %r{(\d+)\.(\d+)} }
  subject { described_class.new( rgx ) }

  describe "from speculations" do
    context "matched but no match" do
      before do
        subject.match("")
      end

      it "is matched now" do
        expect( subject ).to be_matched
      end
      it "however does not have capts" do
        expect( subject.capts ).to be_nil
      end
      it "access to captures are nil too" do
        expect( subject[0] ).to be_nil
      end


    end
  end
end
