module Lab42
  class Match
    NotMatchedYet = Class.new RuntimeError

    attr_reader :rgx, :subject


    def [](capt_index)
      match&.[](capt_index)
    end

    def capts
      match&.captures
    end

    def match(with=nil)
      if with
        return _match(with)
      end
      _assure_matched?
      @match
    end

    def matched?
      @matched
    end

    private

    def _assure_matched?
      raise NotMatchedYet, "you must not execute this operation on an unmatched object" unless matched?
    end

    def _init_defaults
      @match = nil
      @matched = false
    end

    def _match(with)
      @subject = with
      @matched = true
      @match = @rgx.match(with)
    end

    def initialize(rgx, subject=nil)
      @rgx = rgx
      @subject = subject
      _init_defaults
      match if subject
    end

  end
end
