module Lab42
  class Match
    AmbigousArgAndBlock = Class.new RuntimeError
    NotMatchedYet       = Class.new RuntimeError
    UnsuccessfulMerge   = Class.new RuntimeError

    attr_reader :rgx, :subject


    def [](capt_index)
      match&.[](capt_index)
    end

    def capts
      _assure_matched?
      match && @par
      match&.captures
    end

    def groups
      _assure_success
      @groups
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

    def replace(cpt_index, with=nil, &blk)
      _assure_success
      _assure_unambigous_args(with, blk)
      _clone_myself do 
        @parts[cpt_index * 2] = with || blk.(@parts[cpt_index * 2])
      end
    end

    def string
      _assure_success
      @string
    end

    def success?
      !!@match
    end


    private

    def _assure_matched?
      raise NotMatchedYet, "you must not execute this operation on an unmatched object" unless matched?
    end

    def _assure_success
      raise UnsuccessfulMerge, "this operation is not allowed after an unsuccessful merge" unless success?
    end

    def _assure_unambigous_args(arg, blk)
      raise AmbigousArgAndBlock, "you provided #{arg} and a block when only one of them is allowed" if arg && blk
    end

    def _clone_myself &blk
      m = @match
      md = @matched
      parts = @parts.clone
      subject = @subject
      newbie  =
        self
          .class
          .new(rgx)
      newbie .instance_eval do
        @is_dirty = true
        @match    = m
        @matched  = md
        @rgx      = rgx
        @subject  = subject
        @parts    = parts.clone
      end
      newbie.instance_eval(&blk)
      newbie.send(:_refresh)
    end

    def _refresh
      @groups = (1...match.length).map{ |n| @parts[2*n] }
      @string   = @parts.join
      self
    end

    def _init_defaults
      @match = nil
      @matched = false
    end

    def _init_parts
      @parts = [@match.pre_match, subject[@match.begin(0)...@match.begin(1)]]
      (1...@match.size.pred).each do |capture_index|
        @parts << @match[capture_index]
        @parts << subject[@match.end(capture_index)...@match.begin(capture_index.succ)]
      end
      @parts << @match[-1]
      @parts << subject[@match.end(@match.size.pred)...@match.end(0)]
      @parts << @match.post_match
      _refresh
    end

    def _match(with)
      @subject = with
      @matched = true
      @match = @rgx.match(with)
      _init_parts if @match
      self
    end

    def initialize(rgx, subject=nil)
      @rgx = rgx
      @subject = subject
      _init_defaults
      match subject if subject
    end
  end
end
