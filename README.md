

# Lab42Match

[![Build Status](https://travis-ci.org/RobertDober/lab42_match.svg?branch=master)](https://travis-ci.org/RobertDober/lab42_match)
[![Gem Version](https://badge.fury.io/rb/lab42_match.svg)](http://badge.fury.io/rb/lab42_match)
[![Code Climate](https://codeclimate.com/github/RobertDober/lab42_match/badges/gpa.svg)](https://codeclimate.com/github/RobertDober/lab42_match)
[![Issue Count](https://codeclimate.com/github/RobertDober/lab42_match/badges/issue_count.svg)](https://codeclimate.com/github/RobertDober/lab42_match)
[![Test Coverage](https://codeclimate.com/github/RobertDober/lab42_match/badges/coverage.svg)](https://codeclimate.com/github/RobertDober/lab42_match)

Beyond Match Data: Modify Your Matches

... and avoid matching again

## Here is your API

## Wrap a Regex, Get a Match (object)


```ruby :include
    Match = Lab42::Match
    let(:rgx) { %r{(\d+)\.(\d*)} }
    subject { Match.new(rgx) }
```

### Query it

Example: ... to get your wrapped `Regex` back

```ruby :example
    expect( subject.rgx ).to eq(rgx)
```


... or discover that it is not matched yet

```ruby :example
    expect( subject ).not_to be_matched
```

... be aware of accessing data that is not there yet!

```ruby :example not matched yet error
    expect{ subject[0] }.to raise_error(Match::NotMatchedYet) 
```

```ruby :example
    expect{ subject.capts }.to raise_error(Match::NotMatchedYet) 
```

Example: And even the wrapped `MatchData` object must not be accessed

```ruby :example
    expect{ subject.match }.to  raise_error(Match::NotMatchedYet) 
```

### Context Attempt an Unsuccessful Match

However after a first matching attempt the state changes and even if there was no match
your queries will now return nil instead of raising

```ruby :before
    subject.match("")
```

```ruby :example Now we are matched
    expect( subject ).to be_matched
```

```ruby :example capturess are nil
    expect( subject.capts ).to be_nil
```

```ruby :example [] returns nil
    expect( subject[0] ).to be_nil
```

### Context A Successful Match

Now things get more interesting

```ruby :include
    let(:string){ "> 42.43 <" }
    let(:match_data){ subject.rgx.match(string) }
```

```ruby :before
    subject.match(string)
```

Example: Again we are matched now
```ruby :example
    expect( subject ).to be_matched
```
Firstly let us proof that all the information of a `Regex#match` result is accessible

Example: All `MatchData` data is available

```ruby :example
    expect( subject.match ).to eq(match_data)
```

```ruby :example As are the captures
    (0..2).each do |i|
      expect( subject[i] ).to eq(match_data[i])
    end
    expect( subject.capts ).to eq(match_data.captures)
    expect( subject.subject ).to eq(string)
    
```

## Author

Copyright © 2020 Robert Dober
mailto: robert.dober@gmail.com

# LICENSE

Same as Elixir -- &#X1F609; --, which is Apache License v2.0. Please refer to [LICENSE](LICENSE) for details.

SPDX-License-Identifier: Apache-2.0
