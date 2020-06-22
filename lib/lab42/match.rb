module Lab42
  class Match
    attr_reader :match, :rgx, :subject

    def matched?
      !!match
    end

    private

    def initialize(rgx, subject=nil)
      @match = nil
      @rgx = rgx
      @subject = subject
      match if subject
    end
  end
end
