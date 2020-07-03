RSpec.describe Lab42::Match do
  subject { described_class.new(rgx) }

  describe "a simple case" do
    let(:rgx) { %r{\A(\s*)(# )?} }

    context "when an optional group is matched" do
      before do
        subject.match("  # hello")
      end
      it "works just fine" do
        expect(subject.replace(1, "..").string).to eq("..# hello")
      end
    end

    context "when an optional group is not matched" do
      before do
        subject.match("  hello")
      end
      it "also works just fine" do
        expect(subject.replace(1){|pfx| "#{pfx}# " }.string).to eq("  # hello")
      end
    end
  end

  describe "optionals everywhere" do
    context "two" do
      let(:rgx) { %r{\A(a+)?\d+(b+)?\d+(c+)?} }

      it "the happy case" do
        parts = subject.match("a1bb2cc").parts
        expect( parts ).to eq(["", "", "a", "1", "bb", "2", "cc", "", ""])
      end

      it "am I missing an a?" do
        parts = subject.match("1bb2cc").parts
        expect( parts ).to eq(["", "", "", "1", "bb", "2", "cc", "", ""])
      end

      it "or a b?" do
        parts = subject.match("aa12cc").parts
        expect( parts ).to eq(["", "", "aa", "", "", "12", "cc", "", ""])
      end

      it "or a c?" do
        parts = subject.match("aa12bb0").parts
        expect( parts ).to eq(["", "", "aa", "12", "bb", "", "", "0", ""])
      end

      it "not much left I guess" do
        m = subject.match("12")
        expect( m.parts ).to eq(["", "", "", "", "", "", "", "12", ""])
      end

    end
  end
end
